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
end
