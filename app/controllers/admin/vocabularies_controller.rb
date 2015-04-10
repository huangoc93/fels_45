class Admin::VocabulariesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @vocabularies = Vocabulary.page params[:page]
  end

  def new
    @vocabulary = Vocabulary.new
  end  

  def create
    @vocabulary = Vocabulary.new vocabulary_params
    if @vocabulary.save
      flash[:success] = "A new vocabulary is created successfully"
      redirect_back_or admin_vocabularies_path, false
    else
      render 'new'
    end
  end

  def edit
    @vocabulary = Vocabulary.find_by_id params[:id]
  end

  def update
    @vocabulary = Vocabulary.find_by_id params[:id]
    if @vocabulary.update_attributes vocabulary_params
      flash[:success] = "Vocabulary updated"
      redirect_back_or admin_vocabularies_path, false
    else
      render 'edit'
    end
  end

  def destroy
    Vocabulary.find_by_id(params[:id]).destroy
    flash[:success] = "Vocabulary deleted"
    redirect_back_or admin_vocabularies_path, false
  end

  private

  def vocabulary_params
    params.require(:category).permit :spell, :category_id
  end
end
