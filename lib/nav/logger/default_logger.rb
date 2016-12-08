module Nav
  module Logger
    class DefaultLogger < BaseLogger
      def initialize
        @fluent_logger = Fluent::Logger::FluentLogger.new nil
      end
    end
  end
end
