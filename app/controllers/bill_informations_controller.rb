class BillInformationsController < ApplicationController
  
  def index

  end

  def new
  end

  def show
  	
  	bill = current_organization.bills.find(params[:id])
  	@bill_info = bill.bill_information  
  end

  def create
  end
  def update
    @bill_info = BillInformation.find_by_bill_id(params[:billinfo][:bill_id])
    if @bill_info.update(billinfo_params)
       redirect_to bill_information_path
    else 
      flash[:errors] = @bill_info.errors.full_messages
      redirect_to :back
    end
  end

   def edit
  end

  private

    def billinfo_params
      
      params.require(:billinfo).permit(:vendor_name,:vendor_account, :processing_date, :memo, :description, :check_number, :bill_id, :due_date)
    end
end

