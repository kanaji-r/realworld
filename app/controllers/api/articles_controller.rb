class Api::ArticlesController < ApplicationController
  protect_from_forgery
  before_action :set_article, only: %i[show update destroy]

  def index
    @articles = Article.all
    render json: articles_response(@articles)
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json: article_response(@article)
    else
      render json: { errors: article.errors.full_messages }
    end
  end

  def show
    render json: @article
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: { errors: article.errors.full_messages }
    end
  end

  def destroy
    if @article.destroy
      render json: {}
    else
      render json: { errors: article.errors.full_messages }
    end
  end

  private

  def article_response(article)
    {
      article: {
        slug: article.slug,
        title: article.title,
        description: article.description,
        body: article.body,
        createdAt: article.created_at,
        updatedAt: article.updated_at
      }
    }
  end

  def articles_response(articles)
  {
    articles: articles.map do |article|
                { slug: article.slug,
                  title: article.title,
                  description: article.description,
                  body: article.body,
                  createdAt: article.created_at,
                  updatedAt: article.updated_at }
              end,
    articlesCount: articles.count
  }
  end

  def set_article
    @article = Article.find_by(slug: params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body)
    # .merge(slug: article_params[:title].parameterize)
  end
end
