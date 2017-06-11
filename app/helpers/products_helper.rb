module ProductsHelper
  def rating_point_options
    options = []
    11.times do |i|
      options << [pluralize(i, I18n.t("products.show.points")), i]
    end
    options
  end

  def save_to_recent_viewed product_id
    user_id = current_user.id.to_s

    if cookies[:recent_viewed]
      recent_viewed = JSON.parse cookies[:recent_viewed]

      if recent_viewed[user_id]
        product_ids = recent_viewed[user_id]
        product_ids.unshift product_id if product_id != product_ids[0]
        recent_viewed[user_id] = product_ids
      else
        recent_viewed[user_id] = [product_id]
      end
    else
      recent_viewed = {}
      recent_viewed[user_id] = [product_id]
    end

    cookies.permanent[:recent_viewed] = JSON.generate recent_viewed
  end

  def load_recent_viewed_products user_id
    user_id = user_id.to_s
    recent_viewed = JSON.parse cookies[:recent_viewed]
    recent_viewed_product_ids = recent_viewed[user_id]
    recent_viewed_products = []

    recent_viewed_product_ids.each do |id|
      product = Product.find_by id: id

      if product
        recent_viewed_products << product
      else
        recent_viewed_product_ids.delete id
      end
    end

    recent_viewed[user_id] = recent_viewed_product_ids
    cookies.permanent[:recent_viewed] = JSON.generate recent_viewed
    recent_viewed_products.first Settings.product.maximum_recent_viewed_product
  end
end
