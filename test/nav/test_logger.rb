require "helper"

module Nav
  class LoggerTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Nav::Logger::VERSION
    end

    def test_nav_module_logger
      refute_nil ::Nav.logger
    end
  end
end
