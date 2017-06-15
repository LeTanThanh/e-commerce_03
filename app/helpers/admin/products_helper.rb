module Admin::ProductsHelper
  def input_search_product_by_name_value params_product_name
    params_product_name ? params_product_name : ""
  end

  def select_search_product_by_category_id_values
    options = [[t("admin.products.index.all_category"), 0]]
    Category.all.each do |category|
      options << [category.name, category.id]
    end
    options << [t("admin.products.index.unknow"), -1]
  end

  def select_new_product_by_category_id_values
    options = [[t("admin.products.index.unknow"), nil]]
    Category.all.each do |category|
      options << [category.name, category.id]
    end
    options
  end

  def select_search_product_by_category_id_selected params_category
    params_category ? params_category : 0
  end
end
