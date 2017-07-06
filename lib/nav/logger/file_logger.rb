module Nav
  module Logger
    class FileLogger < BaseLogger
      def initialize(path)
        @fluent_logger = Fluent::Logger::ConsoleLogger.new path
        io = @fluent_logger.instance_variable_get "@io"
        io.sync = true
      end
    end
  end
end
