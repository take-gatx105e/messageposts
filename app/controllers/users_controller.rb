class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :destroy, :followings, :followers, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.order(id: :desc).page(params[:page]).per(6)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザの登録を解除しました。'
    redirect_to signup_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(8)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(8)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @fav_messages = @user.fav_messages.page(params[:page]).per(6)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
