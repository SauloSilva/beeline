ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir["#{ File.dirname(__FILE__) }/helpers/*.rb"].each { |file| require file }

class ActiveSupport::TestCase
  include ApiSchemaMatcher
  fixtures :all
end
