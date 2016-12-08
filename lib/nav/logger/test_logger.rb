module Nav
  module Logger
    class TestLogger < BaseLogger
      def initialize
        @fluent_logger = Fluent::Logger::TestLogger.new
      end
    end
  end
end
