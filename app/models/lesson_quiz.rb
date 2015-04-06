class LessonQuiz < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :quiz
end
