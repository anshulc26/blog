class Admin::BlogTagsController < AdminController
	before_filter :authenticate_admin!
	before_action :set_blog_tag, only: [:show, :edit, :update, :destroy_show, :destroy]

  def index
    @blog_tags = BlogTag.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @blog_tag = BlogTag.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @blog_tags = BlogTag.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @blog_tag = BlogTag.new(blog_tag_params)
    if params[:blog_tag][:select_category].present?
      @blog_tag.category = params[:blog_tag][:select_category]
    end
    @blog_tag.save

    redirect_to admin_blog_tags_path, notice: 'Tag was successfully created.'
  end

  def update
    @blog_tag.name = params[:blog_tag][:name]
    if params[:blog_tag][:select_category].present?
      @blog_tag.category = params[:blog_tag][:select_category]
    elsif params[:blog_tag][:category].present?
      @blog_tag.category = params[:blog_tag][:category]
    end
    @blog_tag.save
    
    redirect_to admin_blog_tags_path, notice: 'Tag was successfully updated.'
  end

  def destroy
    @blog_tag.destroy

    redirect_to admin_blog_tags_path, notice: 'Tag was successfully deleted.'
  end

  def destroy_show
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def set_blog_tag
      @blog_tag = BlogTag.find(params[:id])
    end

    def blog_tag_params
      params.require(:blog_tag).permit(:name, :category)
    end
end
