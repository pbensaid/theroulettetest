class ErrorsController < ApplicationController
  def error_404
    render status: 404
  end

  def error_500
    render status: 500
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end