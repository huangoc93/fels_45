class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :vocabularies, dependent: :destroy
  
  accepts_nested_attributes_for :vocabularies, allow_destroy: true,
    reject_if: lambda {|attributes| attributes['spell'].blank?}

  validates :name,  presence: true, uniqueness: true
  
  mount_uploader :avatar, AvatarUploader
end
