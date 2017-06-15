class Admin::ProductsController < ApplicationController
  before_action :verify_login_user!, :verify_admin!

  def index
    product_name = params[:product_name]
    category_id = params[:category_id].to_i
    @products = Product.search(product_name, category_id).order(:name)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page

    respond_to do |format|
      format.html do
        render :index
      end
      format.js do
        render json: {
          html_product_table_container: render_to_string(partial: "admin/products/product_table",
            locals: {products: @products}),
          html_product_paginate: render_to_string(partial: "admin/products/product_paginate",
            locals: {products: @products})
        }
      end
    end
  end
end
