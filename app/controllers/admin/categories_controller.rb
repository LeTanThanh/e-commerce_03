class Admin::CategoriesController < ApplicationController
  include Admin::AdminHelper

  before_action :verify_login_user!, :verify_admin!

  def index
    input = params[:input]
    @categories = Category.search(params[:input]).order(:name)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page

    respond_to do |format|
      format.js do
        render json: {
          html_category_table: render_to_string(partial: "admin/categories/category_table",
            locals: {categories: @categories}),
          html_category_paginate: render_to_string(partial: "admin/categories/category_paginate",
            locals: {categories: @categories})
        }
      end
      format.html do
        @category = Category.new
        render :index
      end
    end
  end

  def create
    category = Category.new name: params[:name]

    if category.save
      flash.now[:success] = t "flash.success.create_category_success"
      respond_to do |format|
        format.js do
          render json: {
            create_category_success: true,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    else
      flash.now[:danger] = t "flash.danger.create_category_fail"
      respond_to do |format|
        format.js do
          render json: {
            create_category_success: false,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
            html_errors: render_to_string(partial: "shared/error_messages",
              locals: {obj: category})
          }
        end
      end
    end
  end

  def update
    category = Category.find_by id: params[:id]

    if category.update_attributes name: params[:name]
      flash.now[:success] = t "flash.success.update_category_success"
      respond_to do |format|
        format.js do
          render json: {
            update_category_success: true,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
            html_category: render_to_string(partial: "admin/categories/category",
              locals: {category: category, category_counter: params[:category_counter].to_i,
                params: {page: params[:page].to_i}})
          }
        end
      end
    else
      flash.now[:danger] = t "flash.danger.update_category_fail"
      respond_to do |format|
        format.js do
          render json: {
            update_category_success: false,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
            html_errors: render_to_string(partial: "shared/error_messages",
              locals: {obj: category})
          }
        end
      end
    end
  end

  def destroy
    category = Category.find_by id: params[:id]

    if category.destroy
      flash.now[:success] = t "flash.success.delete_category_success"
      categories = Category.search(params[:input]).order(:name)
        .paginate page: params[:page], per_page: Settings.will_paginate.per_page
      category = categories.to_a.last
      params[:page] = params[:page].to_i

      respond_to do |format|
        format.js do
          render json: {
            delete_category_success: true,
            html_flash: render_to_string(partial: "layouts/flash",
              locals: {flash: flash}),
            html_category: render_to_string(partial: "admin/categories/category",
              locals: {category: category, params: params,
                category_counter: Settings.will_paginate.per_page})
          }
        end
      end
    else
      flash.now[:danger] = t "flash.danger.delete_category_fail"

      respond_to do |format|
        render json: {
          delete_category_success: false,
          html_flash: render_to_string(partial: "layouts/flash",
            locals: {flash: flash})
        }
      end
    end
  end
end
