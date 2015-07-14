class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_crumb("Home", '/')
  
  class_attribute :shown_to, :editable_by, :model
  self.shown_to = [:all]
  self.editable_by = [:administrators]
  self.model = nil

  def self.controller_display_name
    self.controller_name.underscore.humanize.capitalize
  end
  
  def controller_display_name
    self.class.controller_display_name
  end

  def action_display_name(name=action_name)
    name.humanize.capitalize
  end

  def self.controller_base_path
    "/#{controller_name}"
  end

  def controller_base_path
    self.class.controller_base_path
  end
end
