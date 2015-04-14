class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    if category = Category.find_by_id(params[:category_id])
      @words = category.words
    else
      @words = Word.all
    end

    @words = @words.order(name: params[:sort]) unless params[:sort].blank?
    @words = @words.page params[:page]
  end
end
