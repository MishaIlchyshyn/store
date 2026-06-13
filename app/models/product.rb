class Product < ApplicationRecord
  include Product::Notifications

  has_rich_text :description
  has_one_attached :featured_image

  has_many :wishlist_products, dependent: :destroy
  has_many :wishlists, through: :wishlist_products

  validates :name, presence: true
  validates :inventory_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(created_at: :desc) }

  after_create_commit { broadcast!("create") }
  after_update_commit { broadcast!("update") }
  after_destroy_commit { broadcast!("destroy") }

  private

  def broadcast!(action)
    data = {
      action:,
      product: as_json.merge(
        description: description.to_plain_text,
        featured_image_attached: featured_image.attached?
      )
    }

    ActionCable.server.broadcast("products", data)
  end
end
