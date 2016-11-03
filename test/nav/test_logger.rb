require "helper"

module Nav
  class LoggerTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Nav::Logger::VERSION
    end
  end
end
