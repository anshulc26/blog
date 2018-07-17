class Admin::DashboardController < AdminController
	before_filter :authenticate_admin!
	before_filter :get_user, only: [:user_allowed_to_post, :user_allowed_to_comment, :add_role, :add_roles_to_user]
	
	def index
		@blog_posts = BlogPost.order("id DESC").limit(10)
		@users = User.without_role(:super_admin).last(10)
		@roles = Role.order("id DESC").limit(10)
		@tags = BlogTag.order("id DESC").limit(10)
	end

	def blog_posts
		@blog_posts = BlogPost.order("id DESC").paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
    	format.html
    	format.js
    end
	end

	def users
		@users = User.without_role(:super_admin).order("id DESC").paginate(:page => params[:page], :per_page => 10)
	end

	def blog_allowed_to_show
		blog_post = BlogPost.find(params[:blog_post_id])
		if params[:show].present? && (params[:show] == "on")
			blog_post.show = true
			blog_post.save
		else
			blog_post.show = false
			blog_post.save
		end
		render json: true
	end

	def user_allowed_to_post
		if params[:post].present? && (params[:post] == "on")
			@user.allowed_to_post = true
			@user.save
		else
			@user.allowed_to_post = false
			@user.save
		end
		render json: true
	end

	def user_allowed_to_comment
		if params[:comment].present? && (params[:comment] == "on")
			@user.allowed_to_comment = true
			@user.save
		else
			@user.allowed_to_comment = false
			@user.save
		end
		render json: true
	end

	def add_role
		@roles = Role.all
		@from = params[:from]
	end

	def add_roles_to_user
		if params[:roles].present?
			@user.roles.destroy_all
			params[:roles].each do |role|
				@user.add_role role
			end
		end
		if params[:from] == "users"
			redirect_to admin_users_path, notice: 'Roles was successfully assigned.'
		else
			redirect_to admin_dashboard_index_path, notice: 'Roles was successfully assigned.'
		end
	end

	def get_user
		@user = User.find(params[:user_id])
	end
end
