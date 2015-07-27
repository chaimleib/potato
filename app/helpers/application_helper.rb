include ERB::Util  # gives me the h() method
include ActionView::Helpers::SanitizeHelper
require 'byebug' if Rails.env.development?

module ApplicationHelper

  ALLOW_LINKS = {tags: %w(a wbr), attributes: %w(href)}
  ALLOW_WBR = {tags: %w(wbr)}

  def breakable_uri(uri, breaker='<wbr/>'.html_safe)
    # given a uri, returns a displayabe uri which allows line
    # breaking between sections of the address.
    parts = []  # to be joined, sanitized and returned
    
    temp = h uri
    
    # SCHEMA
    schema = temp.match %r{\Ahttps?://}i
    if schema
      schema = schema[0]
      parts.push schema.html_safe
      temp = temp[schema.length..-1]
    end

    # PATH
    while (m = temp.match %r{\A[^/_\.%]+(?:/|_|\.|%[0-9]{2})+}) do
      m = m[0]
      parts.push h(m)
      temp = temp[m.length..-1]
    end
    parts.push h(temp)
    
    # FINISH
    joined = parts.join breaker
    result = sanitize(joined, ALLOW_WBR).html_safe
    result
  end
  
  def breakable_email(email, breaker='<wbr/>'.html_safe)
    # given an email, returns a displayable email which allows line
    # breaking between sections of the address.

    # HUMANIZED EMAILS
    # formatted like "Fname Lname <email>"
    name = nil
    if email.include? '<'  
      input_parts = email.split '<'
      name = input_parts.first.strip
      email = input_parts[1].strip
      email = email.split('>').first.strip
    end

    # ADDRESS
    parts = []  # to be joined, sanitized and returned
    temp = email
    while (m = temp.match %r{\A[^/_\.%@]+(?:@|/|_|\.|%[0-9]{2})+}) do
      m = m[0]
      parts.push h(m)
      temp = temp[m.length..-1]
    end
    parts.push h(temp)
    
    # HUMANIZED EMAILS
    # add the name again
    if name.present?
      parts.unshift h(' <').html_safe
      parts.push h('>').html_safe
      parts.unshift h(name).html_safe
    end

    # FINISH
    joined = parts.shift
    while parts.present?
      joined << breaker.html_safe
      joined << parts.shift
    end
    result = sanitize(joined, ALLOW_WBR).html_safe
    result
  end

  def format_notices(notice)
    notice = sanitize notice

    classes = ['strong']
    if notice.include? ' success'
      classes << 'green'
    else
      classes << 'red'
    end

    parts = [
      "<ul class=\"#{classes.join ' '}\"><li>".html_safe,
      notice,
      "</li></ul>".html_safe
    ]
    sanitize parts.join, options: ALLOW_LINKS 
  end

  module_function :breakable_uri, :breakable_email
  module_function :format_notices

end
