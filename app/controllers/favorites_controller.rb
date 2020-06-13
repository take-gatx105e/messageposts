class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    message = Message.find(params[:message_id])
    current_user.favorite(message)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    message = Message.find(params[:message_id])
    current_user.unfavorite(message)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
