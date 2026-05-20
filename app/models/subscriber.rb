class Subscriber < ApplicationRecord
  generates_token_for :unsubscribe

  belongs_to :product

  def self.filter_by(params)
    results = all
    results = results.where(product_id: params[:product_id]) if params[:product_id].present?
    results
  end
end
