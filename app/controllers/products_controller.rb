class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @products = Product.order(created_at: :desc).all
  end

  def create
    product = ProductParser.build_product(params[:asin])
    if product
      if product.save
        flash[:notice] = "Product created"
        redirect_to new_product_path
      else
        @errors = product.errors
        @products = Product.order(created_at: :desc).all
        render 'new'
      end
    else
      flash[:error] = 'Invalid ASIN'
      redirect_to new_product_path
    end
  end
end