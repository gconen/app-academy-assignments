class NotesController < ApplicationController
  def create
    @note = Note.new
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    @note.content = params[:content]
    @note.save
    redirect_to :back
  end
end
