class Admin::UsersController < ApplicationController
  include Admin::AdminHelper

  before_action :verify_login_user!, :verify_admin!

  def index
    @users = User.search(params[:input]).select(:id, :email, :name, :is_admin,
      :created_at).order(:name)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page
    respond_to do |format|
      format.js do
        render json: {
          html_user_table: render_to_string(partial: "admin/users/user_table",
            locals: {users: @users}),
          html_user_paginate: render_to_string(partial: "admin/users/user_paginate",
            locals: {users: @users}),
        }
      end
      format.html do
        render :index
      end
    end
  end

  def destroy
    user = User.find_by id: params[:user_id]

    if user.destroy
      flash.now[:success] = t "flash.success.delete_user_success"
      @users = User.search(params[:input]).select(:id, :email, :name, :is_admin,
        :created_at).order(:name)
        .paginate(page: params[:page], per_page: Settings.will_paginate.per_page)
      @user = @users.to_a.last
      respond_to do |format|
        format.js do
          render json: {
            delete_user_success: true,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
            html_user: render_to_string(partial: "admin/users/user",
              locals: {user: @user, user_counter: 9, params: params}),
          }
        end
      end
    else
      flash.now[:danger] = t "flash.danger.delete_user_fail"
      respond_to do |format|
        format.js do
          render json: {
            delete_user_success: false,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
          }
        end
      end
    end
  end
end
