class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def link(text, url)
    "<a href=\"#{url}\">#{text}</a>"
  end
  
  def breadcrumbs
    result = []
    index_path = self.send "#{controller_name}_index_path"
    result.push link controller_display_name, index_path
    
    if action_name != 'index'
      action_path = self.send "#{controller_name}_#{action_name}_path"
      result.push link action_display_name, action_path
    end
    
    result = "&gt; #{result.join ' > '}"
  end
  
  def controller_display_name
    controller_name.underscore.humanize.capitalize
  end
  
  def action_display_name
    action_name.humanize.capitalize
  end
end
