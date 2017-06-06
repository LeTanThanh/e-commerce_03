class ProductsController < ApplicationController
  before_action :load_product, only: [:show, :update]

  def show
    @comments = @product.comments.order created_at: :desc
  end

  def update
    product_id = params[:id]
    point = params[:point]
    rating = current_user.rating_product product_id

    if rating
      rating.update_attributes rating_point: point
    else
      current_user.ratings.create product: @product, rating_point: point
    end

    rating_count = @product.ratings.size
    total_rating_point = @product.ratings.sum :rating_point
    rating_point = (1.0 * total_rating_point / rating_count).round 2

    if @product.update_attributes rating_point: rating_point
      flash[:success] = t "flash.success.send_your_rating_success"
      respond_to do |format|
        format.js do
          render json: {
            save_success: true,
            html: rating_point.to_s << " " << t(".points"),
            html_flash: render_to_string(partial: "/layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    else
      flash[:danger] = t "flash.success.send_your_rating_fail"
      respond_to do |format|
        format.js do
          render json: {
            save_success: false,
            html: render_to_string(partial: "/layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "flash.danger.product_not_found"
    redirect_to root_url
  end
end
