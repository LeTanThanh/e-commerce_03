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

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.danger.user_not_found"
    redirect_to root_url
  end

  def verify_user!
    return if @user.is_user? current_user
    flash[:danger] = t "flash.danger.you_dont_have_permission"
    redirect_to root_url
  end
end
