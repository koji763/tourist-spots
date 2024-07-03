class UsersController < ApplicationController
   before_action :require_user_logged_in, only: [:index, :show, :edit, :destroy]
   before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
  end
  
  def show
    @user = current_user
    @pagy, @tourist_spots = pagy(@user.tourist_spots.order(id: :desc), items: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was successfully registered.'
      redirect_to @user
    else
      flash.now[:danger] = 'User registration failed.'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile has been successfully updated.'
      redirect_to @user
    else
      flash.now[:danger] = 'Your profile could not be updated.'
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    
    flash[:success] = 'Your account has been successfully deleted.'
    redirect_to root_url
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
