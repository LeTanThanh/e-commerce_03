module CartHelper
  def full_cart_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {danger: I18n.t("flash.danger.cart_full")}}
    CGI::escapeHTML html
  end

  def in_cart_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {danger: I18n.t("flash.danger.product_has_been_in_cart_already")}}
    CGI::escapeHTML html
  end

  def add_to_cart_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {success: I18n.t("flash.success.add_product_to_cart_success")}}
    CGI::escapeHTML html
  end

  def update_product_quantity_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {success: I18n.t("flash.success.update_product_in_cart_success")}}
    CGI::escapeHTML html
  end

  def delete_product_in_cart_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {success: I18n.t("flash.success.delete_product_in_cart_flash")}}
    CGI::escapeHTML html
  end

  def order_success_flash
    html = ActionController::Base.new().render_to_string partial: "/layouts/flash",
      locals: {flash: {success: I18n.t("flash.success.delete_product_in_cart_flash")}}
    CGI::escapeHTML html
  end

  def load_order_details_in_cart user_id
    order_details = []
    if cookies[:cart]
      cart = JSON.parse cookies[:cart]
      load_cart cart, user_id.to_s, order_details if cart
    end
    cookies.permanent[:cart] = JSON.generate cart
    order_details
  end

  def load_cart cart, user_id, order_details
    return unless cart[user_id]
    cart[user_id].each do |key, value|
      product = Product.find_by id: key
      if product
        order_detail = OrderDetail.new product: product, quantity: value, price: product.price
        order_details << order_detail
      else
        cart[user_id].delete key
      end
    end
  end

  def total_price order_details
    total_price = 0
    order_details.each do |order_detail|
      total_price += order_detail.price * order_detail.quantity
    end
    total_price
  end
end
