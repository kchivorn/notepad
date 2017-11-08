class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @notes = current_user.notes.order(created_at: :desc)
  end

  def show

  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      redirect_to @note, notice: "The note was created successfully."
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @note.update_attributes(note_params)
      redirect_to @note, notice: "The note was updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def set_note
    @note = current_user.notes.find(params[:id])
  end
end
