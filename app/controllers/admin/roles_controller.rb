class Admin::RolesController < AdminController
	before_filter :authenticate_admin!
	before_action :set_role, only: [:show, :edit, :update, :destroy_show, :destroy]

  def index
    @roles = Role.all.order("id DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @role = Role.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @role = Role.new(role_params)
    @role.save

    redirect_to admin_roles_path, notice: 'Role was successfully created.'
  end

  def update
    @role.update(role_params)

    redirect_to admin_roles_path, notice: 'Role was successfully updated.'
  end

  def destroy
    @role.destroy

    redirect_to admin_roles_path, notice: 'Role was successfully deleted.'
  end

  def destroy_show
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name)
    end
end
