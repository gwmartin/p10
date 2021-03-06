# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'sinatra'
require "sinatra/reloader" if development?

if development? || test?
  require 'pry-debugger'
  require 'dotenv'
  Dotenv.load
end

require 'twilio-ruby'
require 'resque'
require 'resque-scheduler'
require 'chronic'
require 'uri'
require 'pathname'
require 'pg'
require 'active_record'
require 'logger'
require 'erb'

require 'active_support/time_with_zone'
require 'active_support/core_ext/time/zones'
Time.zone = "Pacific Time (US & Canada)"
Chronic.time_class = Time.zone

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
  # Configure Redis (hopefully)
  # services = JSON.parse(ENV['VCAP_SERVICES'])
  # redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
  # redis = services[redis_key].first['credentials']
  # redis_conf = { :host => redis['hostname'], :port => redis['port']. :password => redis['password'] }
  # @@redis = Redis.new redis_conf
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'workers', '*.rb')].each { |file| require file }


# Set up the database and models
require APP_ROOT.join('config', 'database')


Resque.schedule = YAML.load_file Bundler.root.join('config/worker_schedule.yml')
