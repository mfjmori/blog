class UsersController < ApplicationController

  def show
    @articles = User.find(params[:id]).articles.order("created_at DESC").page(params[:page]).per(5)
  end
end
