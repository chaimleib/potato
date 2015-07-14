class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_crumb("Home", '/')
  
  def self.controller_display_name
    self.controller_name.underscore.humanize.capitalize
  end
  
  def controller_display_name
    self.class.controller_display_name
  end

  def action_display_name(name=action_name)
    name.humanize.capitalize
  end
end
