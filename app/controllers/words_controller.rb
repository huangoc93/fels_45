class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    category = Category.find_by_id(params[:category_id])
    if params[:word_type] == "learned"
      @words = current_user.learned_words category
    elsif params[:word_type] == "not learned"
      @words = current_user.not_learned_words category
    else
      @words = category.nil? ? Word.all : category.words
    end

    @words = @words.order(name: params[:sort]) unless params[:sort].blank?
    @words = @words.page params[:page]
  end
end
