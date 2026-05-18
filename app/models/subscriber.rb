class Subscriber < ApplicationRecord
  generates_token_for :unsubscribe

  belongs_to :product
end
