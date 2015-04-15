class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show]

  def show
    @lesson = Lesson.find_by_id params[:id]
    unless params[:answer].nil?
      current_quiz = @lesson.lesson_words.not_answered.first
      current_quiz.update_attributes(
          correct: current_quiz.word.answers.right.first.content == params[:answer])
    end 
    @next_quiz = @lesson.lesson_words.not_answered.first
    if @next_quiz.nil?
      Activity.create!(user_id: current_user.id,
                       description: "Learned #{@lesson.lesson_words.right.count}/"\
                                    "#{@lesson.lesson_words.count} words in Lesson "\
                                    "'#{@lesson.category.name}'")
    end 
  end

  def create
    lesson = Lesson.create!(user_id: current_user.id,
                            category_id: params[:category_id])
    current_user.not_learned_words(lesson.category).each.with_index do |word, index|
      break if index >= 10 
      LessonWord.create!(lesson_id: lesson.id, word_id: word.id)
    end
    redirect_to lesson_path lesson
  end

  private

  def correct_user
    @lesson = Lesson.find_by_id params[:id]
    redirect_to categories_path unless current_user.id == @lesson.user_id
  end
end
