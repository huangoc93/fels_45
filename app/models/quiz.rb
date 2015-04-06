class Quiz < ActiveRecord::Base
  belongs_to :vocabulary
  has_many :lesson_quizzes, dependent: :destroy
  has_many :lessons, through: :lesson_quizzes
end
