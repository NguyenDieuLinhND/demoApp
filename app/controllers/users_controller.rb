class UsersController < ApplicationController

  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:show, :destroy, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :birthday, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end
