class CartController < ApplicationController
  include CartHelper

  before_action :verify_login_user!, only: :show

  def show
    @order_details = load_order_details_in_cart current_user.id
  end
end
