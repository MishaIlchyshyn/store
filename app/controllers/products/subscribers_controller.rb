module Products
  class SubscribersController < ApplicationController
    allow_unauthenticated_access
    before_action :set_product

    def create
      @product.subscribers.where(email: subscriber_params['email']).first_or_create
      redirect_to @product, notice: "You have subscribed to this product."
    end

    private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
  end
end
