class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /articles
  def index
    @articles = policy_scope(Article)
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      current_user.articles << @article
      flash[:notice] = 'Article was successfully created.'
      redirect_to @article
    else
      flash[:error] = 'Article could not be saved.'
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was successfully updated.'
      redirect_to @article
    else
      flash[:error] = 'Article could not be saved.'
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article)
      .permit(:title, :body,
              (:published if current_user.role == "editor"))
  end
end
