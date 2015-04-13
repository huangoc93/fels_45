class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:content].blank?}

  validates :name,  presence: true, uniqueness: true
end
