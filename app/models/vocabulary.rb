class Vocabulary < ActiveRecord::Base
  belongs_to :category
  has_one :quiz, dependent: :destroy
end
