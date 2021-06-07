class ArticlesController < ApplicationController
  before_action :authenticate, except: %i[index show]

  def index
    @selected_tag = params[:tag]
    @articles = Article.includes(:tags, :user,
                                 :favoriters).where(tags: { name: params[:tag] }).order(created_at: :desc).all
    @tags = Tag.all
    @title = 'Popular articles | Sawir Forum'
  end

  def new
    @article = Article.new
    @tags = Tag.includes(:articles).all.sort_by { |tag| tag.articles.length }.reverse!
    @title = 'Create new article | Sawir Forum'
  end

  def create
    @article = current_user.articles.new(
      title: params[:article][:title],
      body: params[:article][:body],
      description: params[:article][:description]
    )

    unless params[:article][:tags].empty?
      params[:article][:tags].each do |tag|
        @article.tags << Tag.find_or_create_by(name: tag)
      end
    end

    if @article.save!
      redirect_to edit_article_path(@article.slug), notice: 'Article successfully created'
    else
      @tags = Tag.all
      flash.now[:error] = 'Something went wrong'
      @title = 'Create new article | Sawir Forum'
      render :new
    end
  end

  def show
    @article = Article.includes(:user, :comments, :tags).where(slug: params[:slug]).first!
    @comment = Comment.new
  end

  def edit
    @article = Article.includes(:tags).where(slug: params[:slug]).first
    @tags = Tag.includes(:articles).all.sort_by { |tag| tag.articles.length }.reverse!
    redirect_to article_path(@article.slug) unless @article.user.id == current_user.id
  end

  def update
    @article = current_user.articles.find_by(slug: params[:slug])
    @article.tags.clear if params[:article][:tags].empty?

    unless params[:article][:tags].empty?
      @article.tags = params[:article][:tags].map do |tag|
        Tag.find_or_create_by(name: tag)
      end
    end
    @article.title = params[:article][:title]
    @article.body = params[:article][:body]
    @article.description = params[:article][:description]

    if @article.save!
      redirect_to edit_article_path(@article.slug), notice: 'Article was successfully updated'
    else
      @tags = Tag.all
      flash.now[:error] = 'Something went wrong'
      @title = "Edit #{@article.title} | Sawir Forum"

      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find_by(slug: params[:slug])
    if @article.destroy
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong!'
      redirect_back(fallback_location: article_path(@article.slug))
    end
  end

  private

  def new_article_params
    params.require(:article).permit(:title, :body, :description, tags: [])
  end
end
