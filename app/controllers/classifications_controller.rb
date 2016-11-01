class ClassificationsController < ApplicationController

   def create
      if params[:term].present?
        @result = current_user.created_terms.new(term_params)
      elsif params[:location].present?
        @result = current_user.created_locations.new(location_params)
      elsif params[:department].present?
        @result = current_user.created_departments.new(department_params)
      end

     if @result.save
        case (@result.class.to_s)
        when "Term"
          resp = { id: @result.id, name: @result.name, for: "term" }
          render json: resp
        when "Location"
          resp = { id: @result.id, name: @result.name, for: "location" }
          render json: resp
        when "Department"
          resp = { id: @result.id, name: @result.name, for: "department" }
          render json: resp
        end
     else
       render json: @result.errors.full_messages, status: :unprocessable_entity
     end
   end

   private
     def term_params
       params
         .require(:term)
         .permit(:name)
     end

     def location_params
       params
         .require(:location)
         .permit(:name)
     end

     def department_params
       params
         .require(:department)
         .permit(:name)
     end
end
