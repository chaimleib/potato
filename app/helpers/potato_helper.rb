module PotatoHelper
  # pj  is short for PotatoJira, an instance of 
  # app/helpers/potato_core/jira_adapter. It connects to JIRA.
  
  def ensure_potato_jira(session)
    pj = JiraAdapter.new
  end
  
  def get_task_list_by_version(user, session, pj)
    n = Time.now
    data = {
      'Unversioned' => {
        :tasks => 3,
        :time => nil
      },
      'v13.0.0.1' => {
        :tasks => 6,
        :time => n + 6.days
      },
      'v12.0.1' => {
        :tasks => 1,
        :time => n + 4.minutes
      }
    }
    
  end
end
