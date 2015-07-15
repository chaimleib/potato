namespace :heroku do
  desc "Sets up heroku config variables on foreign server."

  class HerokuServer
    attr_accessor :plans

    def initialize
      @_name = nil
      @plans = []
    end

    def name
      return @_name unless @_name.nil?
      conf = %x(heroku config)
      words = conf.split("\n").first.split(' ')
      if words[0].first == '='
        @_name = words[1]
      end
      @_name
    end
  end

  server = HerokuServer.new 

  task :name do
    puts server.name
  end

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

    unless system "heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git"
      raise 'Failed to set BUILDPACK_URL'
    end
  end

  task :dbinit do
    puts ">> Reading addons..."
    addons = %x(heroku addons)
    plans = []
    found_plans = false
    addons.split("\n").each{|line|
      found_plans_header |= line =~ /\APlan/i
      if found_plans_header
        found_plans = true
        next
      end
      next unless found_plans
      next if %w(- =).include? line.first
      break if line.strip.empty?
      line = line.strip.squeeze ' '
      cols = line.split ' '
      plans << cols.first
    }

    if plans.include? 'cleardb:ignite'
      puts ">> ClearDB already installed"
    else
      puts ">> Installing ClearDB MySQL..."
      system('heroku addons:create cleardb:ignite')
    end

    puts '>> Setting CLEARDB_DATABASE_URL...'
    unless system('heroku config:set "$(heroku config |
      grep CLEARDB_DATABASE_URL | 
      sed -e \'s/^.*\/\//DATABASE_URL=mysql2:\/\//\')"')
      raise(["Failed to set DATABASE_URL",
        "Do you still have heroku-postgresql installed? If so, run\n",
        "\theroku addons:destroy heroku-postgresql",
        "\theroku addons:create cleardb:ignite\n"].join "\n")
    end

    puts '>> Initializing databases...'
    system 'heroku run rake db:drop db:create db:migrate db:seed'
    puts '>> Done'
  end
end