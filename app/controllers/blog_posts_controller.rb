class BlogPostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_blog_post, only: [:edit, :update, :destroy]
  before_filter :set_flickr, only: [:create, :destroy]
  before_filter :check_user_allowed, only: [:new, :create]

  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.includes(:user).friendly.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def create
    if params[:blog_post][:image].present?
      image_id = flickr.upload_photo(params[:blog_post][:image].tempfile.path, title: params[:blog_post][:title], description: "Blog Pic")
      image_url_original = FlickRaw.url_o(flickr.photos.getInfo(photo_id: image_id))
      image_url_thumb = FlickRaw.url_m(flickr.photos.getInfo(photo_id: image_id))
    end

    @blog_post = BlogPost.new(user_id: current_user.id, title: params[:blog_post][:title], description: params[:blog_post][:description], image_id: image_id, image_url_original: image_url_original, image_url_thumb: image_url_thumb)
    if (current_user.has_role? :super_admin) || (current_user.has_role? :admin)
      @blog_post.show = true
    end
    respond_to do |format|
      if @blog_post.save
        if params[:blog_post][:tags].present?
          params[:blog_post][:tags].each do |tag|
            @blog_post.tag_list.add(tag)
          end
        end
        @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created' }
        format.json { render action: 'show', status: :created, location: @blog_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    flickr.photos.delete(photo_id: @blog_post.image_id)
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end

  private
    def check_user_allowed
      if !current_user.allowed_to_post?
        redirect_to blog_posts_path, notice: 'Currently you are not allowed to create Blog post'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :description)
    end
end
