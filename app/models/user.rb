class User < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :lessons, dependent: :destroy

  attr_accessor :remember_token
  USERNAME_VALID_REGEX = /\A[A-Za-z0-9\-_]+\z/
  validates :username,  presence: true, length: {maximum: 20},
                        format: {with: USERNAME_VALID_REGEX},
                        uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  validates :password, length: {minimum: 5}, allow_blank: true

  mount_uploader :avatar, AvatarUploader
  validate  :avatar_size

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end
 
  def authenticated?(attribute, token)
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def fullname
    self.name.blank? ? self.username : self.name
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def following_activities
    Activity.where("user_id IN (?) OR user_id = ?", following_ids, id)
            .order(created_at: :desc)
  end

  def learned_words category = nil
    all_lessons = category.nil? ? self.lessons :
                  Lesson.where("user_id = ? AND category_id = ?", self.id, category.id)
    lesson_words = LessonWord.where("lesson_id IN (?) AND correct = true", 
                                     all_lessons.map(&:id))
    Word.where("id IN (?)", lesson_words.map(&:word_id))
  end

  def not_learned_words category = nil
    all_not_learned_words = Word.where("id NOT IN (?)", learned_words.map(&:id))
    words_in_category = category.nil? ? Word.all
                                      : Word.where("category_id = ?", category.id)
    Word.where("id IN (?) AND id IN (?)", 
      all_not_learned_words.map(&:id), words_in_category.map(&:id))
  end

  private

  def avatar_size
    if avatar.size > 2.megabytes
      errors.add(:avatar, "should be less than 2MB")
    end
  end
end
