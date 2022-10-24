class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    picture= @article.picture.create(picture_params)
    @article.picture.attach(picture)

    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to root_path
    else
      flash[:error] = "Article could not be saved, try again!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
      flash[:success] = "Article has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "Article has been successfully deleted!"

    redirect_to root_path, status: :see_other
  end


  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :picture)
    end

    def picture_params
      params.require(:picture).permit(:article_id, :picture, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at)
    end
end
