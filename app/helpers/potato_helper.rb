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
    data = pj.get_task_tallies_by_version user
    # order the data
    sorted_keys = data.keys.sort
    sorted_keys.delete('Unversioned')
    sorted_keys.unshift 'Unversioned' if data.has_key? 'Unversioned'

    result = {
      :overview_table_rows => sorted_keys,
      :overview_table_data => data,
      :overview_username => user
    }
  end
end

