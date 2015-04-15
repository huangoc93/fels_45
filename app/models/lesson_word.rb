class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word

  scope :right, -> {where correct: true}
  scope :answered, -> {where "correct IS NOT NULL"}
  scope :not_answered, -> {where "correct IS NULL"}
end