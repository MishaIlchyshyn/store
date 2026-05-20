class Wishlist < ApplicationRecord
  belongs_to :user

  has_many :wishlist_products, dependent: :destroy
  has_many :products, through: :wishlist_products

  to_param :name

  def self.filter_by(params)
    wishlists = all
    wishlists = wishlists.where(user_id: params[:user_id]) if params[:user_id].present?
    if params[:product_id].present?
      wishlists = wishlists.joins(:wishlist_products).where(wishlist_products: { product_id: params[:product_id] })
    end

    wishlists
  end
end
