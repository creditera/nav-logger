module Nav
  module Logger
    class BaseLogger
      attr_reader :fluent_logger

      def level
        @level ||= ::Logger::DEBUG
      end

      def level_name(lookup = level)
        ::Logger::SEV_LABEL[lookup]
      end

      def level_symbol
        level_name.downcase.to_sym
      end

      def level=(new_level)
        if new_level.is_a? Integer
          @level = new_level
        else
          lookup = new_level.to_s.upcase
          @level = ::Logger::SEV_LABEL.index lookup
        end
      end

      def debug(message, hash = {})
        add ::Logger::DEBUG, message, hash
      end

      def info(message, hash = {})
        add ::Logger::INFO, message, hash
      end

      def warn(message, hash = {})
        add ::Logger::WARN, message, hash
      end

      def error(message, hash = {})
        add ::Logger::ERROR, message, hash
      end

      def fatal(message, hash = {})
        add ::Logger::FATAL, message, hash
      end

      private

        def add(severity, message, hash)
          severity = severity.nil? ? ::Logger::UNKNOWN : severity.to_i
          return true if severity < level

          severity_name = level_name severity
          log_hash = generate_log_hash severity_name, message, hash
          @fluent_logger.post tag(severity_name), log_hash
        end

        def app_tag
          return @app_tag if defined? @app_tag
          @app_tag = defined?(::APP_PREFIX) ? ::APP_PREFIX.downcase : nil
        end

        def environment
          @environment ||= ENV["RACK_ENV"] || ENV["APP_ENV"] || "development"
        end

        def hostname
          @hostname ||= Socket.gethostname
        end

        def generate_log_hash(severity, message, input)
          hash = input.merge RequestStore.store
          hash.merge! message: message,
                      level: severity,
                      ts: Time.now.to_f,
                      environment: environment,
                      hostname: hostname,
                      pid: pid
          hash
        end

        def pid
          @pid ||= Process.pid
        end

        def tag(severity)
          [app_tag, severity.downcase].compact.join "."
        end
    end
  end
end
