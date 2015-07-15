class WelcomeController < ApplicationController
  # @config = @@default_config.deep_dup

  def index
    Rails.application.eager_load! if Rails.env.development?
    @admin_controllers = WelcomeHelper.admin_controllers
  end
end
