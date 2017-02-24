module Nav
  module Logger
    module Middleware
      class RequestTagger

        def initialize(app)
          @app = app
        end

        def call(env)
          setup_request_store
          store_request_var env
          @app.call env
        ensure
          clear_request_store
        end

        private
          def setup_request_store
            RequestStore.begin!
          end

          def store_request_var(env)
            RequestStore[:request_id] = env["HTTP_X_REQUEST_ID"] || SecureRandom.uuid
            RequestStore[:session_id] = env["HTTP_X_SESSION_ID"] if env.key? "HTTP_X_SESSION_ID"
          end

          def clear_request_store
            RequestStore.end!
            RequestStore.clear!
          end

      end
    end
  end
end
