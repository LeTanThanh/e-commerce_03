class Admin::RequestsController < ApplicationController
  before_action :verify_login_user!, :verify_admin!

  def index
    @requests = Request.all.order(created_at: :desc)
      .select(:id, :user_id, :content, :message, :status, :created_at)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page
  end

  def update
    request_counter = params[:request_counter].to_i
    page = params[:page].to_i
    request = Request.find_by id: params[:id]
    if request.update_attributes status: params[:request_status]
      respond_to do |format|
        format.js do
          render json: {
            html: render_to_string(partial: "admin/requests/request",
              locals: {request: request, page: page,
              request_counter: request_counter})
          }
        end
        format.html {redirect_to :back}
      end
    else
      flash[:danger] = t "flash.danger.update_request_status_fail"
      redirect_to :back
    end
  end
end
