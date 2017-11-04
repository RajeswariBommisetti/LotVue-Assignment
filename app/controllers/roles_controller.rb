class RolesController < ApplicationController
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params) 
    if @role.save
      flash[:success] = "Role successfully created"
      redirect_to @role
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @roles = Role.all
  end

  def hide_roles
  end

  def update_roles
    if params[:role][:name].present?
      Role.where(:id=>params["role"]["name"].collect(&:to_i)).each do |a|
        a.update_attribute(:active, false)
      end
      flash[:success] = "Role successfully updated"
    end
    redirect_to roles_url
  end

  def show
    @role = Role.find(params[:id])
  end

  private

  def role_params
    params.require(:role).permit(:name, :active)      
  end
end
