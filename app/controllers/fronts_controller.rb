class FrontsController < ApplicationController
  before_action :authenticate, only: [:feed]
  def index
    @articles = Article.includes(:tags, :user, :favoriters).order(created_at: :desc).all
    @tags = Tag.all
  end

  def feed
    @articles = Article.includes(:tags, :user,
                                 :favoriters).where(favoriters: { user_id: current_user.id }).order(created_at: :desc).all
    @tags = Tag.all
  end
end
