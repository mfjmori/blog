class ArticlesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]
  before_action :set_article, except: [:index, :new, :create]

  def index
    if user_signed_in? == false
      @articles = Article.where(publish: true).includes(:user).order("created_at DESC").page(params[:page]).per(5)
    else
      @articles = Article.where('publish = ? or user_id = ?', true, current_user.id).includes(:user).order("created_at DESC").page(params[:page]).per(5)
    end
  end

  def show
    if @article.publish == false && @article.user_id != current_user.id
      redirect_to action: :index
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    redirect_to action: :index if @article.user_id != current_user.id
  end

  def update
    redirect_to action: :index if @article.user_id != current_user.id
    if @article.update(article_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @article.destroy if @article.user_id == current_user.id
    redirect_to action: :index
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def article_params
    params.require(:article).permit(:title, :content, :publish).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
