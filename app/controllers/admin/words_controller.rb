class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @words = Word.page params[:page]
  end

  def new
    @word = Word.new
    4.times {@word.answers.build}
  end  

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = "A new word is created successfully"
      redirect_to edit_admin_word_path(@word)
    else
      render 'new'
    end
  end

  def edit
    @word = Word.find_by_id params[:id]
  end

  def update
    @word = Word.find_by_id params[:id]
    if @word.update_attributes word_params
      flash[:success] = "Word updated"
      redirect_to edit_admin_word_path(@word)
    else
      render 'edit'
    end
  end

  def destroy
    Word.find_by_id(params[:id]).destroy
    flash[:success] = "Word deleted"
    redirect_to admin_words_path
  end

  private

  def word_params
    params.require(:word).permit(:name, :category_id,
      answers_attributes: [:id, :content, :correct, :_destroy])
  end
end
