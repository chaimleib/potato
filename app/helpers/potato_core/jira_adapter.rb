require 'potato_core/jira_connection'

class JiraAdapter
  attr_reader :con, :jira
  
  def initialize
    @con = JiraConnection.new
    @jira = @con.client
  end
  
end

PotatoJira = JiraAdapter.new

