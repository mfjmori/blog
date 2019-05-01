class ArticlesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]
  before_action :set_article, except: [:index, :new, :create]

  def index
    @articles = Article.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def show
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
    redirect_to action: :index unless @article.user_id == current_user.id
  end

  def update
    if @article.user_id == current_user.id
      if @article.update(article_params)
        redirect_to action: :index
      else
        render :edit
      end
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
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
