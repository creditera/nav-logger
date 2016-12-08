module Nav
  module Logger
    class ConsoleLogger < BaseLogger
      def initialize
        @fluent_logger = Fluent::Logger::ConsoleLogger.open STDOUT
      end
    end
  end
end
