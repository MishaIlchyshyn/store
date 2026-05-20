class WishlistProduct < ApplicationRecord
  belongs_to :product, counter_cache: true
  belongs_to :wishlist, counter_cache: true

  validates :product_id, uniqueness: { scope: :wishlist_id }
end
