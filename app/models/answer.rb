class Answer < ActiveRecord::Base
  belongs_to :word

  validates :content,  presence: true

  scope :right, -> {where correct: true}
end
