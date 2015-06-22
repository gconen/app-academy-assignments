class NotesController < ApplicationController
  def create
    current_user.notes << Note.create(track_id: params[:track_id],
                                      content: params[:content])
    redirect_to :back
  end
end
