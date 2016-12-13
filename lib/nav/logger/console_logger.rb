module Nav
  module Logger
    class ConsoleLogger < BaseLogger
      # Mapping of color/style names to ANSI control values
      CODEMAP = {
        normal: 0,
        bold: 1,
        black: 30,
        red: 31,
        green: 32,
        yellow: 33,
        blue: 34,
        magenta: 35,
        cyan: 36,
        white: 37
      }

      # Map of log levels to colors
      LEVELMAP = {
        "FATAL" => :red,
        "ERROR" => :red,
        "WARN" => :yellow,
        "INFO" => :green, # default color
        "DEBUG" => :cyan
      }

      def initialize
        @fluent_logger = Fluent::Logger::ConsoleLogger.open STDOUT

        # Adds colorized loigging
        def @fluent_logger.post_with_time(tag, map, time)
          a = [time.strftime(@time_format), " ", tag, ":"]
          map.each_pair { |k,v|
            a << " #{k}="
            a << JSON.dump(v)
          }

          color = LEVELMAP[map[:level]] || :green

          a.unshift "\e[#{CODEMAP[color]}m"
          a << "\e[#{CODEMAP[:normal]}m"

          post_text a.join
          true
        end
      end
    end
  end
end
