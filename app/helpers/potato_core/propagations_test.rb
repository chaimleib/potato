require 'potato_core/jira_adapter'
jira = JiraAdapter.new
jira.get_tasks_by_propagation 'user'
