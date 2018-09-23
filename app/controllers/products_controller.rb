class ProductsController < ApplicationController
  def new
    @product = Product.new
    @products = Product.order(created_at: :desc).all
  end

  def create
    product = ProductParser.build_product(params[:product][:asin])
    if product && product.save
      flash[:notice] = "Product created."
    else
      flash[:error] = 'ASIN invalid.'
    end

    redirect_to new_product_path
  end
end