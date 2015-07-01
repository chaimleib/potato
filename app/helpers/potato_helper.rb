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
    data = pj.get_task_tallies_by_version user
    # order the data
    sorted_keys = data.keys.sort
    sorted_keys.delete('Unversioned')
    sorted_keys.unshift 'Unversioned' if data.has_key? 'Unversioned'

    if sorted_keys.empty? && pj.get_user(user).nil?
      errors[:user].push 'No such user'
    end

    result = {
      :overview_table_rows => sorted_keys,
      :overview_table_data => data,
      :overview_username => user
    }
  end

  def format_tasks_by_propagation(user, session, pj)
    errors = {
      user: []
    }
    data = pj.get_tasks_by_propagation user
    due_nil = []
    due_set = []
    data.each do |line|
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
      :propagations_table_data => sorted_data,
      :propagations_username => user,
      :jira_issue_uri_base => "#{Rails.application.secrets.jira['host']}/browse",
      :errors => errors
    }
  end
end

