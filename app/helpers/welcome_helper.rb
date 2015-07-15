module WelcomeHelper
  def self.admin_controllers
    controllers = ApplicationController.descendants.select &:model
  end
end
