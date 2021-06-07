class CommentsController < ApplicationController
  before_action :authenticate

  def create
    article = Article.find_by(slug: params[:slug])
    comment = article.comments.new(body: params[:comment][:body], user_id: current_user.id)
    if comment.save!
      redirect_to article_path(article.slug), notice: 'Comment successfully created'
    else
      flash[:error] = 'Something went wrong. Your comment was not saved.'
      redirect_to article_path(article.slug)
    end
  end

  def edit
    @article = Article.find_by(slug: params[:slug])
    @title = "Edit comment #{@article.title} | Sawir Forum"
    @comment = @article.comments.find(params[:comment_id])
  end

  def update
    article = Article.find_by(slug: params[:slug])
    comment = article.comments.find(params[:comment_id])
    if comment.update(body: params[:comment][:body])
      redirect_to article_path(article.slug), notice: 'Successfully edited your comment.'
    else
      flash[:error] = 'Something went wrong. Failed to edit your comment.'
      @title = "Edit comment #{@article.title} | Sawir Forum"
      redirect_to article_path(article.slug)
    end
  end

  def destroy
    article = Article.find_by(slug: params[:slug])
    comment = article.comments.find(params[:comment_id])
    if comment.destroy!
      redirect_to article_path(article.slug), notice: 'Comment was successfully deleted.'
    else
      flash[:error] = 'Something went wrong. Your comment was not deleted.'
      redirect_to article_path(article.slug)
    end
  end
end
