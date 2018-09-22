class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product = ProductParser.build_product(params[:product][:asin])
    if product && product.save
      flash[:notice] = "Product was created."
      redirect_to new_product_path
    else
      flash[:error] = 'ASIN invalid.'
      redirect_to new_product_path
    end
  end

  def index
    @products = Product.all
  end
end