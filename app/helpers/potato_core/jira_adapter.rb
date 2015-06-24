require 'potato_core/jira_connection'

class JiraAdapter
  def initialize
    @con = JiraConnection.new
  end
  
end

PotatoJira = JiraAdapter.new

