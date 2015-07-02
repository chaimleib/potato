# module:: PotatoHelper
# Contains code that sorts and formats the data for HAML.
# 
# Hierarchy:
#   * potato_core/jira_connection - login, HTTPS, REST client setup
#   * potato_core/jira_adapter    - JQL, JSON, HTML, raw data aggregation
#   * PotatoHelper                - sorting and formatting for HAML
#   * PotatoController            - sessions, params, form interaction, page rendering

module PotatoHelper
  require 'potato_core/jira_adapter'
  # pj  is short for PotatoJira, an instance of 
  # app/helpers/potato_core/jira_adapter. It connects to JIRA.
  
  def ensure_potato_jira(session)
    pj = JiraAdapter.new
  end
  
  def format_task_tallies_by_version(user, session, pj)
    errors = {
      user: []
    }
    user_splits = split_users user
    multi_user = user_splits.length > 1
    data = pj.get_task_tallies_by_version user_splits

    sorted_keys = data.keys.sort
    if data.has_key? 'Unversioned'
      sorted_keys.delete 'Unversioned'
      sorted_keys.unshift 'Unversioned'
    end
    if data.has_key? 'Backlog'
      sorted_keys.delete 'Backlog'
      sorted_keys.push 'Backlog'
    end

    sorted_data = sorted_keys.map{|key| data[key]}

    if sorted_keys.empty? && pj.get_user(user).nil?
      errors[:user].push 'No such user'
    end

    result = {
      :multi_user => multi_user,
      :overview_table_data => sorted_data,
      :overview_username => user_splits.join(', '),
      :errors => errors
    }
  end

  def format_tasks_by_propagation(user, session, pj)
    errors = {
      user: []
    }
    user_splits = split_users user
    multi_user = user_splits.length > 1

    data = pj.get_tasks_by_propagation user_splits
    due_nil = []
    due_set = []
    data.each do |line|
      multi_user = true if line[:user] != user_splits.first
      
      if line[:due].nil?
        line[:due_nil] = true
        due_nil.push line
      else
        line[:due_nil] = false
        due_set.push line
      end
    end
    sorted_data = due_nil.sort_by{|line| line[:key]}
    sorted_data.push *(due_set.sort_by{|line| line[:due]})


    if sorted_data.empty? && pj.get_user(user).nil?
      errors[:user].push 'No such user'
    end

    result = {
      :multi_user => multi_user,
      :propagations_table_data => sorted_data,
      :propagations_username => user,
      :jira_issue_uri_base => "#{Rails.application.secrets.jira['host']}/browse",
      :errors => errors
    }
  end

  def split_users(users)
    users.
      split(',').
      map(&:strip).
      map{|user| user.squeeze(" \t\r\n")}
  end
end

