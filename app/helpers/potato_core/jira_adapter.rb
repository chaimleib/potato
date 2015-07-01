require 'potato_core/jira_connection'
require 'potato_core/version_scraper'

class JiraAdapter
  attr_reader :connection, :jira
  
  def initialize
    @connection = JiraConnection.new
    @jira = @connection.client
  end
  
  ### CALLED BY PotatoHelper ###
  
  def get_task_tallies_by_version(user)
    issues = get_task_list_by_version user
    n = Time.now
    data = {}
    
    # tally the tasks
    issues.each do |ver, tasks|
      data[ver] = { :tasks => tasks.length }
    end
    
    # assign due dates
    freezes = fetch_code_freeze_dates
    data.each do |ver, row|
      row[:time] = get_code_freeze_date_for_version freezes, ver
    end
    data
  end
  
  def get_tasks_by_propagation(user=@connection.username)
    require 'pry'
    require 'utilities/object_cleaner'
    n = Time.now
    data = []
    conditions = [
      'updated > -14d',
      'status in (resolved,"code propagation",closed,"code review","ready to merge")'
    ]
    issues = get_issues conditions, user
    issues.each do |issue|
      line = {}
      puts issue.key
      line[:key] = issue.key
      line[:status] = issue.status.name
      line[:target] = target = issue.target_branch_name
      line[:prs] = issue.pull_requests
      if issue.has_parent?
        line[:parent] = issue.parent['key']
        parent = issue.parent['fields']
        line[:parent_status] = parent['status']['name']
        parent_target = parent[JIRA::Resource::Issue::TARGET_BRANCH_KEY]
        line[:parent_target] = parent_target.nil? ? nil : parent_target['name']
      else
        line[:parent] = nil
        line[:parent_status] = nil
        line[:parent_target] = nil
      end

      dd = DueDate.find_by(branch_name: target)
      line[:due] = dd.nil? ? nil : Time.strptime(dd.due, '%m/%d/%Y')

      data.push line
    end

    binding.pry
  end
  
  
  ### INTERNAL ###
  
  def get_task_list_by_version(user)
    issues = get_open_issues user
    issues.delete_if &:has_parent?
      
    sorted = sort_issues_by_version_category issues
    sorted.each{ |ver, issues|
      sorted[ver] = issues.map &:key
    }
    sorted
  end
  
  def fetch_code_freeze_dates
    host_path = '/wiki/display/CP/CD+Maintenance+Releases'
    html = @connection.submit_get host_path
    freezes = VersionScraper.scrape_freeze_dates html
  end
  
  def get_code_freeze_date_for_version(code_freezes, version)
    version = version[1..-1] if %w(v V).include? version[0]
    return code_freezes[version] if code_freezes[version].present?
    nil
  end
  
  def sort_issues_by_version_category(issues)
    result = {}
    _add_to_version = proc do |issue, version|
      result[version] = [] if !result.has_key? version
      result[version].push issue
    end
    issues.each do |issue|
      version = issue_version_category issue
      _add_to_version.call issue, version
    end
    result
  end
  
  def issue_affected_versions(issue)
    versions = issue.versions.map &:name
  end
  
  def issue_version_category(issue)
    target = issue.target_version
    return target['name'] if target
    versions = issue.versions.map &:name
    earliest = versions.min
    return earliest if earliest
    "Unversioned"
  end
  
  def get_issue(issue='CD-29175')
    issue = @jira.Issue.find issue
  end
  
  def get_issues(conditions=[], username=@connection.username)
    conditions.unshift "assignee=#{ActiveRecord::Base::sanitize username}"
    query = conditions.join " AND "
    query += " order by updated desc"
    puts query
    issues = @jira.Issue.jql query
  end
  
  def get_open_issues(username=@connection.username)
    conditions = [
      'updated > -14d',
      'status not in (Closed,Resolved)',
    ]
    issues = get_issues conditions, username
  end
  
  def get_user(username=@connection.username)
    user = @jira.User.find username
    pp user
  end

  def get_projects
    projects = @jira.Project.all
    projects.each do |project|
      puts "#{project.key}: #{project.name}"
    end
  end

  ### DEBUG ONLY ###
  def print_issue_array(issues)
    issues.each do |issue|
      # parent = issue.fields.parent.key
      status = issue.status.name
      description = issue.description
      if description
        description.gsub! "\n", ' '
        description.gsub! "\r", ''
      else
        description = '<No description>'
      end
      versions = issue.versions.map &:name
      versions = versions.join ', '
      if versions.empty?
        versions = 'No versions assigned'
      else
        versions = "Versions: #{versions}"
      end
      puts "# #{issue.key} #{issue.updated} (#{status}): #{versions}"
      puts description
      puts ''
    end
  end
end

