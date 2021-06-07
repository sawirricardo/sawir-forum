class FavoritersController < ApplicationController
  before_action :authenticate

  def create
    article = Article.find_by(slug: params[:slug])
    favoriter = Favoriter.new(article_id: article.id, user_id: current_user.id)
    redirect_back(fallback_location: article_path(article.slug)) if favoriter.save
  end

  def destroy
    article = Article.find_by(slug: params[:slug])
    favorite = article.favoriters.find_by(user_id: current_user.id)
    redirect_back(fallback_location: article_path(article.slug)) if favorite.destroy
  end
end
