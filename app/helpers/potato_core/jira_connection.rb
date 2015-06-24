#!/usr/bin/env ruby

#require 'rubygems'
require 'jira'
require 'uri'
require 'jira-extensions/issue'


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

end

#if __FILE__ == $0
#  con = JiraConnection.new
#  puts con.submit_get '/wiki/display/CP/CD+Maintenance+Releases'
#end

