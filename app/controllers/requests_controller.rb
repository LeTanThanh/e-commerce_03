class RequestsController < ApplicationController
  before_action :verify_login_user!

  def index
    @request = current_user.requests.new
  end

  def create
    @request = current_user.requests.new request_params

    if @request.save
      flash[:success] = t "flash.success.send_your_request_success"
      redirect_to root_url
    else
      flash.now[:danger] = t "flash.danger.send_your_request_fail"
      render :index
    end
  end

  private

  def request_params
    params.require(:request).permit :content
  end
end
