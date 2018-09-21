class ProductsController < ActionController::Base
  def new
    @product = Product.new
  end

  def create
    product = ProductParser.create(params[:product][:asin])
  end

  def index
    @products = Product.all
  end
end