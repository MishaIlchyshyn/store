class Product < ApplicationRecord
  include Product::Notifications

  has_rich_text :description
  has_one_attached :featured_image

  has_many :wishlist_products, dependent: :destroy
  has_many :wishlists, through: :wishlist_products

  validates :name, presence: true
  validates :inventory_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
