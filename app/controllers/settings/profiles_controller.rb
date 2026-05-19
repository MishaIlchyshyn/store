module Settings
  class ProfilesController < ApplicationController
    def show
    end

    def update
      if Current.user.update(profile_params)
        redirect_to settings_profile_path, status: :see_other, notice: "Your profile has been updated."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def profile_params
      params.require(:user).permit(:first_name, :last_name, :email_address)
    end
  end
end
