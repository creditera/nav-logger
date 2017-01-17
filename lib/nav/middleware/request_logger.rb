module Nav
  module Logger
    class RequestLogger

      def initialize(app)
        @app = app
      end

      def call(env)
        start_time = Time.now
        status, headers, body = @app.call env
        rescue
          status ||= 500
          body ||= ""
          headers ||= {
            "X-Request-Id" => RequestStore[:request_id],
            Rack::CONTENT_LENGTH => body.length.to_s
          }
        ensure
          log_request start_time, env, status, headers
          [status, headers, [body]]
      end

      private
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
