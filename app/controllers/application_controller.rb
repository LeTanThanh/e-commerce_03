class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  def error_404
    render file: "public/404.html", status: :not_found
  end

  private

  def verify_login_user!
    return if logged_in?
    flash[:danger] = t "flash.danger.you_have_to_login"
    redirect_to root_url
  end

  def verify_admin!
    return if current_user.is_admin?
    flash[:danger] = t "flash.danger.you_are_not_admin_user"
    redirect_to root_url
  end
end
