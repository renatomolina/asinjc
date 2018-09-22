class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product = ProductParser.build_product(params[:product][:asin])
    if product && product.save
      flash[:notice] = "Product was created."
    else
      flash[:error] = 'ASIN invalid.'
    end

    redirect_to new_product_path
  end

  def index
    @products = Product.all
  end
end