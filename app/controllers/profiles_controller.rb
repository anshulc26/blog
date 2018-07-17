class ProfilesController < ApplicationController

	before_filter :authenticate_user!

	def index
	end

	def edit_profile
	end
end
