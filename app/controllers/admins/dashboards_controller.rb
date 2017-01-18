class Admins::DashboardsController < Admins::ApplicationController

  def index
  	@bills = Bill.where(paid: nil)
    @news = News.all
  end

  def create
  end

  def new
  end

  def search
  	keywords = params[:keywords]
  	if keywords.present?
  		@results = User.where("first_name ILIKE ?", "%#{keywords}%") + Organization.where("name ILIKE ?", "%#{keywords}%")
  	else
  		@results = []
  	end
  end

end
