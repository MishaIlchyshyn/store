module Settings
  class ProfilesController < BaseController
    def show
    end

    def update
      if Current.user.update(profile_params)
        redirect_to settings_profile_path, status: :see_other, notice:
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      terminate_session
      Current.user.destroy

      redirect_to root_path, notice: "Your account has been deleted."
    end

    def confirm_email
      user = User.find_by_token_for(:email_confirmation, params[:token])

      if user&.confirm_email
        flash[:notice] = "Your email has been confirmed."
      else
        flash[:alert] = "Invalid token."
      end

      redirect_to settings_root_path
    end

    private

    def notice
      if new_email.present?
        "A confirmation email has been sent to #{new_email}."
      else
        "Your profile has been updated."
      end
    end

    def new_email
      profile_params[:unconfirmed_email]
    end

    def profile_params
      permitted = params.require(:user).permit(:first_name, :last_name, :email_address)

      if Current.user.email_address != permitted[:email_address]
        permitted[:unconfirmed_email] = permitted[:email_address]
        permitted[:email_address] = Current.user.email_address
      end

      permitted
    end
  end
end
