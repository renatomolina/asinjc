class ProductsController < ActionController::Base
  def new
    @product = Product.new
  end

  def create
    product = ProductParser.create(params[:product][:asin])
    product.save!
    flash[:notice] = "Product was created."
    redirect_to new_product_path
  end

  def index
    @products = Product.all
  end
end