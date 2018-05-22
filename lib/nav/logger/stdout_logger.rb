module Nav
  module Logger
    class StdoutLogger < BaseLogger
      def initialize
        @fluent_logger = Fluent::Logger::ConsoleLogger.open STDOUT
      end
    end
  end
end
