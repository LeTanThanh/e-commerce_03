module Admin::CategoriesHelper
  def search_category_input_value params_input
    params_input ? params_input : ""
  end
end
