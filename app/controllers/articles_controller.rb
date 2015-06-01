class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
    @comments = Comment.where(article_id: params[:id])
    render json: @article
  end

  def create
    @article = Article.new(params[:article_params])
    @article.user_id = current_user.id if current_user
    if @article.save
      render json: @article
    else
      render json: @article.errors.full_messages
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.update!(:article_params)
    render json: @article
  end

  def delete
    articles = Article.all
    @article.destroy
    render json: @articles
  end

  private
  def article_params
      params.require(:article).permit(:title, :content)
  end

end
