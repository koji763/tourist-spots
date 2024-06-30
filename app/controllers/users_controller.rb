class UsersController < ApplicationController
  def index
  end
  
  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'Your profile has been successfully updated.'
      redirect_to @user
    else
      flash.now[:danger] = 'Your profile could not be updated.'
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = 'Your account has been successfully deleted.'
    redirect_to root_url
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon)
  end
  
end
