class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  attr_readonly :admin

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :first_name, :last_name, presence: true

  after_update :send_email_notification

  generates_token_for :email_confirmation, expires_in: 7.days do
    unconfirmed_email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def confirm_email
    update(email_address: unconfirmed_email, unconfirmed_email: nil)
  end

  private

  def send_email_notification
    return unless saved_change_to_unconfirmed_email?

    UserMailer.with(user: self).email_confirmation.deliver_later
  end
end
