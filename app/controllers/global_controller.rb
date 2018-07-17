class GlobalController < ApplicationController
	def about_us
	end

	def team
	end

	# GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    @user = User.find(params[:id])
    if request.patch? && params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to profile_path( username: @user.username ), notice: 'Your profile was successfully updated.'
      else
        @show_error = true
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
