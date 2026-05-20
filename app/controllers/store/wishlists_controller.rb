module Store
  class WishlistsController < Store::BaseController
    def index
      @wishlists = Wishlist.includes(:user)
    end

    def show
      @wishlist = Wishlist.find(params[:id])
    end
  end
end
