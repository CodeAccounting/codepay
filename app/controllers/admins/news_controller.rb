class Admins::NewsController < Admins::ApplicationController
	load_and_authorize_resource
	
	def index
		@news = News.all
	end

	def create
		@news = News.new(news_params)
		if @news.save
			redirect_to admins_news_index_path
		else
			flash[:errors] = @news.errors.full_messages
			redirect_to new_admins_news_path
		end	
	end

	def show
		@news = News.find(params[:id])
	end

	def news_params
		params.require(:news).permit(:subject, :description)
	end	

	def delete
		if params[:news_ids].present?
		   news = News.where(id: params[:news_ids])
		   if news.present?
		   	 news.destroy_all
		   end	
		   redirect_to admins_news_index_path
		else
		   flash[:errors] = ["Please Select Atleast One News To Delete"]
		   redirect_to admins_news_index_path
		end		
	end
end
