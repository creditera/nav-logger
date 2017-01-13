module Nav
  module Logger
    class RequestTag

      def initialize(app)
        @app = app
      end

      def call(env)
        setup_request_store
        store_request_var env
        status, headers, body = @app.call env
        headers["X-Request-Id"] ||= RequestStore[:request_id]
        clear_request_store
        [status, headers, [body]]
      end

    private
      def setup_request_store
        RequestStore.begin!
      end

      def store_request_var(env)
        RequestStore[:request_id] = env["HTTP_X_REQUEST_ID"] || SecureRandom.uuid
        RequestStore[:session_id] = env["HTTP_X_SESSION ID"] if env.key? "HTTP_X_SESSION_ID"
      end

      def clear_request_store
        RequestStore.end!
        RequestStore.clear!
      end

    end
  end
end
