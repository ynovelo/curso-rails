class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show,:index]
	#before_action :validate_user, except: [:show,:index]
	before_action :set_article, except: [:index, :new, :create]


	#GET /articles
	def index
		# Todos los registros select * from Articles
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@article.update_visits_count
		#@article = Article.find(params[:id])
		#where
		#Article.where("id = ? AND title = ?", params[:id], params[:title])
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		# @article = Article.new(title:params[:article][:title], 
		# 	body: params[:article][:body])
		# #@article.valid?
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy #Destroy elimina el objeto de la bd
		redirect_to articles_path

	end


	#PUT /articles/:id
	def update
		# @article.update_attributes({title: 'Nuevo title'})
		#@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	def edit
		#@article = Article.find(params[:id])


	end



	private

	def article_params


		params.require(:article).permit(:title,:body)
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end

	def set_article
		@article = Article.find(params[:id])
	end
end