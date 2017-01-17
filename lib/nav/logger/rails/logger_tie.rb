module Nav
  module Logger
    module Rails
      class LoggerTie < ::Rails::Railtie
        initializer "logger_tie.configure_rails_initialization" do |app|

          # We add the request id and session it from the RequestStore as tags
          # on all Rails logs.
          app.config.log_tags ||= []
          app.config.log_tags << lambda { |_arg| RequestStore[:request_id] }
          app.config.log_tags << lambda { |_arg| RequestStore[:session_id] }

          # We insert the nav logger middleware into the middleware stack.  We
          # need to insert it before the Rails::Rack::Logger, since that is when
          # the tag lambdas get executed. If the Nav Logger middleware hasn't
          # already been run the request store will be empty and the lambdas
          # will come back nil.
          app.config.middleware.insert_before(
            ::Rails::Rack::Logger,
            Nav::Logger::Middleware::RequestTagger
          )

        end
      end
    end
  end
end
