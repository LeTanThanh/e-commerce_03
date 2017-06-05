class UsersController < ApplicationController
  before_action :verify_login_user!, :load_user, :verify_user!,
    only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.success.welcome_to_shop"
      redirect_to @user
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] =  t "flash.success.update_user_success"
      redirect_to @user
    else
      flash.now[:danger] = t "flash.danger.update_user_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
