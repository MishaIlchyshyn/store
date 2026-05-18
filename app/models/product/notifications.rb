module Product::Notifications
  extend ActiveSupport::Concern

  included do
    has_many :subscribers, dependent: :destroy
    after_update_commit :notify_subscribers, if: :back_in_stock?
  end

  private

  def back_in_stock?
    saved_change_to_inventory_count? && inventory_count > 0
  end

  def notify_subscribers
    subscribers.find_each do |subscriber|
      ProductMailer.with(product: self, subscriber:).in_stock.deliver_later
    end
  end
end
