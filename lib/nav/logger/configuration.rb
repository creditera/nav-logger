module Nav
  module Logger
    class Configuration
      attr_reader :filter_keys

      def initialize
        @filter_keys = []
      end

      def filter_keys=(val)
        raise InvalidConfigValueError, "Configuration 'filter_keys' must be an Array" if !val.instance_of? Array
        @filter_keys = val
      end

      class InvalidConfigValueError < StandardError; end
    end
  end
end