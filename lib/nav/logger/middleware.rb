module Nav
  module Logger
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        # setup_request_store
        # store_request_vars env
        start_time = Time.now
        # status, headers, body = @app.call env
        # headers["X-Request-Id"] ||= RequestStore[:request_id]
        # [status, headers, body]
      rescue
        status ||= 500
        body ||= ""
        headers ||= {
          "X-Request-Id" => RequestStore[:request_id],
          Rack::CONTENT_LENGTH => body.length.to_s
        }
        [status, headers, [body]]
      ensure
        log_request start_time, env, status, headers
        clear_request_store
      end

      private
        # def store_request_vars(env)
        #   RequestStore[:request_id] = env["HTTP_X_REQUEST_ID"] || SecureRandom.uuid
        #   RequestStore[:session_id] = env["HTTP_X_SESSION_ID"] if env.key? "HTTP_X_SESSION_ID"
        # end

        # def setup_request_store
        #   RequestStore.begin!
        # end

        # def clear_request_store
        #   RequestStore.end!
        #   RequestStore.clear!
        # end

        def log_request(start_time, env, status, headers)
          rack_log_hash = {
            remote_addr: env["HTTP_X_FORWARDED_FOR"] || env["REMOTE_ADDR"] || "-",
            remote_user: env["REMOTE_USER"] || "-",
            request_method: env[Rack::REQUEST_METHOD],
            request_path: env[Rack::PATH_INFO],
            query_string: env[Rack::QUERY_STRING].empty? ? "" : "?#{env[Rack::QUERY_STRING]}",
            status: status.to_s[0..3],
            content_length: extract_content_length(headers),
            duration: Time.now - start_time,
            level: status_level(status)
          }

          tag = Nav.logger.log_tag "http"
          Nav.logger.post tag, rack_log_hash
        end

        def status_level(status)
          return "ERROR" if status.nil?
          case status.to_i
          when 400..499 then "WARN"
          when 500..599 then "ERROR"
          else               "INFO"
          end
        end

        def extract_content_length(headers)
          return "-" if headers.nil?
          value = headers[Rack::CONTENT_LENGTH] or return "-"
          value.to_s == "0" ? "-" : value
        end
    end
  end
end
