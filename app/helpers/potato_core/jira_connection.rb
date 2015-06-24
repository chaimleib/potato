#!/usr/bin/env ruby

#require 'rubygems'
require 'jira'
require 'uri'
require 'pp'
require 'utilities/object_cleaner'
require 'jira-extensions/issue'
require 'pry'
#require 'rails'


class JiraConnection
  ## Email username
  #USER_RGX = /^[^@]+@[^@]+$/
  ## Identifier username
  USER_RGX = /^[-_a-zA-Z0-9\.]+$/
  
  URI_RGX = /^https?:\/\/[-.\/a-zA-Z0-9]+$/
  
  attr_reader :client, :username
  
  def initialize
    # These three are loaded from Rails.application.secrets.jira:
    # @username = 'username'
    # @password = 'password'
    # @host = 'https://www.example.com'
    load_config
    validate

  end

  def load_config
    cfg = Rails.application.secrets.jira

    @username, @password = cfg['username'], cfg['password']
    @host = cfg['host']
    
    options = {
      :username => @username,
      :password => @password,
      :site => @host,
      :context_path => '',
      :auth_type => :basic
    }
    @client = JIRA::Client.new options
  end
  
  def validate
    raise "`#{@username}` is an invalid username for JIRA" if @username !~ USER_RGX
    raise "No password provided" if @password.empty?
    raise "`#{@host}` is an invalid host URI" if @host.empty? || @host !~ URI_RGX
  end
  
  def submit_get(path='')
    return if path.empty?
    path = URI.escape path
    path = "/#{path}" if path[0] != '/'
    uri = URI.parse "#{@host}/#{path}"
    puts uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth @username, @password
    response = http.request(request)
    raise "#{response.code}: #{response.message}" if response.code !~ /20[0-9]/
    response.body
  end

  def get_projects
    projects = @client.Project.all
    projects.each do |project|
      puts "#{project.key}: #{project.name}"
    end
  end

  def get_user(username=@username)
    user = @client.User.find username
    pp user
  end

  def get_issues(username=@username)
    conditions = [
      "assignee=#{ActiveRecord::Base::sanitize username}",
      #'project=CD',
      'updated > -14d',
      'status not in (Closed,Resolved)',
    ]
    query = conditions.join " AND "
    query += " order by updated desc"
    puts query
    issues = @client.Issue.jql query
  end
  
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
    versions
  end
  
  def issue_version_category(issue)
    target = issue.target_version
    return target['name'] if target
    earliest = issue_affected_versions(issue).min
    return earliest if earliest
    "Unversioned"
  end
    
  def overview(username=@username)
    issues = get_issues username
    issues.delete_if &:has_parent?
      
    sorted = sort_issues_by_version_category issues
    sorted.each{ |ver, issues|
      sorted[ver] = issues.map &:key
    }
    sorted
  end

  def get_issue(issue='CD-29175')
    issue = @client.Issue.find issue
    binding.pry
  end
end

#if __FILE__ == $0
#  con = JiraConnection.new
#  puts con.submit_get '/wiki/display/CP/CD+Maintenance+Releases'
#end

