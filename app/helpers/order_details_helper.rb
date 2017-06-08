module OrderDetailsHelper
  def product_quantity_options
    options = []
    10.times do |i|
      options << [pluralize(i + 1, I18n.t("order_details.order_detail.product")), i + 1]
    end
    options
  end
end
