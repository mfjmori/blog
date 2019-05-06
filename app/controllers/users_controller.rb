class UsersController < ApplicationController

  def show
    if user_signed_in? == false
      @articles = User.find(params[:id]).articles.where(publish: true).order("created_at DESC").page(params[:page]).per(5)
    else
      @articles = User.find(params[:id]).articles.where('publish = ? or user_id = ?', true, current_user.id).order("created_at DESC").page(params[:page]).per(5)
    end
  end
end
