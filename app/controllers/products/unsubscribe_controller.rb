module Products
  class UnsubscribeController < ApplicationController
    allow_unauthenticated_access
    before_action :set_subscriber

    def show
      @subscriber&.destroy
      redirect_to root_path, notice: "Unsubscribed successfully."
    end

    private
    def set_subscriber
      @subscriber = product.subscribers.find_by_token_for(:unsubscribe, params[:token])
    end

    def product
      @product ||= Product.find(params[:product_id])
    end
  end
end
