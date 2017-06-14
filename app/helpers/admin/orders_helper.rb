module Admin::OrdersHelper
  def order_status_options
    options = []
    Order.order_statuses.each do |status|
      options << status
    end
    options
  end

  def search_order_status_params
    order_status_options.unshift [I18n.t("admin.orders.index.all_status"), -1]
  end

  def search_order_user_input_value user_params
    user_params ? user_params : ""
  end

  def search_order_status_select_value status_params
    status_params ? status_params : -1
  end
end
