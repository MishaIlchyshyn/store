class UserMailer < ApplicationMailer
  def email_confirmation
    user = params[:user]
    @token = user.generate_token_for(:email_confirmation)

    mail to: user.unconfirmed_email, subject: "Confirm your new email address"
  end
end
