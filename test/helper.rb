$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "nav/logger"

require "minitest/autorun"
require "minitest/pride"

Nav::Logger.configure do |config|
  config.filter_keys = [:secret_key, :password]
end