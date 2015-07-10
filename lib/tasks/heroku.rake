namespace :heroku do
  desc "Sets up heroku config variables on foreign server."

  task :config do
    env_keys = %w(JIRA_USER JIRA_KEY JIRA_HOST)
    env_vars_present = env_keys.all?{|key| ENV[key].present?}
    unless env_vars_present
      raise 'ENV vars not set'
    end
    unless env_keys.all?{|key| system "heroku config:set #{key}=#{ENV[key].inspect}"}
      raise 'Failed to config remote ENV'
    end

    require 'securerandom'
    secret_key_base = SecureRandom.hex(64)
    unless system("heroku config:set SECRET_KEY_BASE=#{secret_key_base.inspect}")
      raise 'Failed to set SECRET_KEY_BASE'
    end
  end
end