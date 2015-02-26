class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception

  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  #end

  protected
    def not_found
      puts "hello"
      raise ActionController::RoutingError.new('Not Found')
    end

    def restrict_to_development
      head(:bad_request) unless Rails.env.development?
    end

  private
    def render_error(status, exception)
      if(status == 404)
        logger.info "Not Found: '#{request.fullpath}'.\n#{exception.class} error was raised for path .\n#{exception.message}"
      else
        logger.info "System Error: Tried to access '#{request.fullpath}'.\n#{exception.class} error was raised for path .\n#{exception.message}"
      end

      respond_to do |format|
        format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
        format.all { render nothing: true, status: status }
      end
    end

end
