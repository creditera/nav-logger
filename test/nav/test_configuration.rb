require "helper"

module Nav
  module Logger
    class ConfigurationTest < Minitest::Test
      def test_that_configuration_initializes
        assert_equal Nav::Logger.configuration.filter_keys, [:secret_key, :password]
      end

      def test_that_enforces_parameter_type
        assert_raises Nav::Logger::Configuration::InvalidConfigValueError do
          Nav::Logger.configure do |config|
            config.filter_keys = "secret_key"
          end
        end
      end
    end
  end
end
