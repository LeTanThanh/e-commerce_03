module Admin::AdminHelper
  def admin_page params_page
    params_page.nil? ? 1 : params_page.to_i
  end

  def admin_no params_page, object_counter
    page = admin_page params_page
    (page - 1) * Settings.will_paginate.per_page + object_counter + 1
  end
end
