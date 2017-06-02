class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def error_404
    render file: "public/404.html", status: :not_found 
  end
end
