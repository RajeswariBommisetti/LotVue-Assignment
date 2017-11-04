class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      params["user"]["user_roles"].collect(&:to_i).each do |i|
        if i != 0
          @user.roles << Role.where(id: i).first
        end
      end
      flash[:success] = "User successfully created"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def update
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end

  def index
    @users = User.joins(:roles).where("roles.active = ?", true).distinct.paginate(page: params[:page], per_page: 3)
    respond_to do |format|
      format.html
      format.js
    end
    # render json: {content: render_to_string(partial: 'view',
    #                                      formats: [:html],
    #                                      layout: false,
    #                                      locals: { users: @users }) }
  end

  def show_users
    @users = User.joins(:roles).where("roles.active = ?", true).distinct.paginate(page: params[:page], per_page: 3)
    respond_to do |format|
      format.js
    end
  end

  def show
    @user = User.find(params[:id])

  end

  def home
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :email, :lastname, :role_id, :avatar)
      
  end
end
