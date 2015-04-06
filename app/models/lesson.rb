class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_quizzes, dependent: :destroy
  has_many :quizzes, through: :lesson_quizzes
end
