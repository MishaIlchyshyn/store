class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @products = Product.ordered
  end

  def show
    @product = Product.find_by(id: params[:id])

    redirect_to root_path, alert: "Product not found." unless @product
  end
end
