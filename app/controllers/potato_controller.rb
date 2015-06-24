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

class PotatoController < ApplicationController
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
    
    @context = format_task_list_by_version user, session, pj
  end
end
