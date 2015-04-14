class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @words = Word.page params[:page]
  end
end
