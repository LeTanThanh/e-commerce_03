class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def show
    @comments = @product.comments.order created_at: :desc
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.danger.product_not_found"
    redirect_to root_url
  end
end
