class Vocabulary < ActiveRecord::Base
  belongs_to :category
  has_one :quiz, dependent: :destroy

  validates :spell,  presence: true, uniqueness: true
end
