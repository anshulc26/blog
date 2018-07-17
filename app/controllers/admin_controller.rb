class AdminController < ApplicationController
	layout "admin"

	def index
	end

	def sign_in
		@resource = User.new
		@resource_name = :admin
		render layout: false
	end

	def authenticate_admin!
		if current_user.present?
			if !(current_user.has_role? :super_admin) || !(current_user.has_role? :admin)
				redirect_to root_path, alert: "You are not authorized to access this part"
			end
		else
			redirect_to admin_sign_in_path
		end
	end
end
