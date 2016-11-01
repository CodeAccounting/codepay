class NotesController < ApplicationController

	def show
	end

	def ajax_to_add_note
		# debugger
		note = current_organization.notes.new(noteable_id: params[:id].to_i, noteable_type: params[:type], body: params[:body])
		note.creator = current_user
		if note.save
			render json: note.to_json(:include => :creator)
		end		
	end

	def notes_list_by_ajax
      notes = current_organization.notes.where(noteable_id: params[:id], noteable_type: params[:type])
      render json: notes.to_json(:include => :creator)
  	end
end
