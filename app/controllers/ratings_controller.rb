class RatingsController < ApplicationController
  include RatingsHelper

  def create
    product = Product.find_by id: params[:product_id]
    rating = current_user.ratings.new create_rating_params

    if rating.save
      response_success product
    else
      response_fail
    end
  end

  def update
    product = Product.find_by id: params[:product_id]
    rating = Rating.find_by id: params[:rating_id]

    if rating.update_attributes update_rating_params
      response_success product
    else
      response_fail
    end
  end

  private

  def create_rating_params
    params.permit :product_id, :rating_point
  end

  def update_rating_params
    params.permit :rating_point
  end

end
