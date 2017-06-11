class ProductsController < ApplicationController
  include ProductsHelper

  before_action :load_product, only: :show

  def index
    unless params[:search]
      @recent_viewed_products = load_recent_viewed_products current_user.id
      render :recent_viewed_products
      return
    end
  end

  def show
    @comments = @product.comments.order created_at: :desc
    save_to_recent_viewed @product.id if logged_in?
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.danger.product_not_found"
    redirect_to root_url
  end
end
