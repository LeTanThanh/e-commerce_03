class StaticPagesController < ApplicationController
  def home
    @hot_trend_products = Product.hot_trend.select :id, :picture
    @products = Product.select(:id, :picture, :name, :price, :quantity)
      .paginate page: params[:page], per_page: Settings.will_paginate.per_page_product
  end

  def show
    if valid_page?
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  
  def valid_page?
    File.exist? Pathname.new Rails.root + 
    	"app/views/static_pages/#{params[:page]}.html.erb"
  end
end
