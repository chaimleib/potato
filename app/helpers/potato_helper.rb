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
  
  def ensure_potato_jira(session=nil)
    pj = JiraAdapter.new
  end
  
  def format_task_tallies_by_version(user, session, pj)
    errors = {
      user: []
    }
    user_splits = split_users user
    multi_user = user_splits.length > 1
    data = pj.get_task_tallies_by_version user_splits

    front = []
    back = []
    middle = []
    data.each do |ver, line|
      line[:due] = nil
      case ver
      when 'Unversioned'
        front.push line
      when 'Backlog'
        back.push line
      else
        due = DueDate.for_version ver
        line[:due] = due
        if due.nil?
          front.push line
        else
          middle.push line
        end
      end
    end
    front = front.sort_by{|line| line[:version]}
    middle = middle.sort_by{|line| line[:due]}

    sorted_data = front + middle + back

    if sorted_data.empty? && pj.get_user(user).nil?
      errors[:user].push 'No such user'
    end

    result = {
      multi_user: multi_user,
      overview_table_data: sorted_data,
      overview_username: user_splits.join(', '),
      errors: errors,
      jira_host: pj.jira.options[:site]
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
      due = DueDate.for_version line[:target]
      line[:due] = due
      if due.nil?
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
      multi_user: multi_user,
      propagations_table_data: sorted_data,
      propagations_username: user,
      errors: errors,
      jira_host: pj.jira.options[:site]
    }
  end

  def split_users(users)
    users.
      split(',').
      map(&:strip).
      map{|user| user.squeeze(" \t\r\n")}
  end
end

