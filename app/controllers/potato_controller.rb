# class:: PotatoController
# Contains action methods for GUI linkage and rendering.
# 
# Hierarchy:
#   * potato_core/jira_connection - login, HTTPS, REST client setup
#   * potato_core/jira_adapter    - JQL, JSON, HTML, raw data aggregation
#   * PotatoHelper                - sorting and formatting for HAML
#   * PotatoController            - sessions, params, form interaction, page rendering

require 'potato_helper'
include PotatoHelper
require 'byebug' if Rails.env.development?

class PotatoController < ApplicationController
  add_crumb controller_display_name, controller_base_path

  def index
  end
  
  def overview    
    pj = ensure_potato_jira session
    if params[:user].present?
      user = params[:user]
    elsif session.has_key? :viewed_user
      user = session[:viewed_user]
    else
      user = pj.connection.username
    end
    session[:viewed_user] = user
    
    respond_to do |format|
      format.html {
        autocrumb
        @context = {
          user: user,
          jira_host: pj.jira.options[:site]
        }
      }
      format.json {
        @context = format_task_tallies_by_version user, session, pj    
      }
    end
  end
  
  def propagations
    pj = ensure_potato_jira session
    if params[:user].present?
      user = params[:user]
    elsif session.has_key? :viewed_user
      user = session[:viewed_user]
    else
      user = pj.connection.username
    end
    session[:viewed_user] = user

    respond_to do |format|
      format.html {
        autocrumb
        @context = {
          user: user,
          jira_host: pj.jira.options[:site]
        }
      }
      format.json {
        @context = format_tasks_by_propagation user, session, pj
      }
    end
  end
end

