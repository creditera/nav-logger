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

    end
  end
end
