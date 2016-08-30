class User < ActiveRecord::Base
    mount_uploader :avatar, AvatarUploader

  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
   validates :age, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 130}, on: :update
   validates :profile, presence: true, length: { minimum: 15, maximum: 145 }, on: :update
   validates :location, presence: true, length: {minimum: 7, maximum: 50 }, on: :update
  # validates :latitude, numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }, on: :update
  has_secure_password
  has_many :microposts


has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
has_many :following_users, through: :following_relationships, source: :followed
  
  
has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
has_many :follower_users, through: :follower_relationships, source: :follower

  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

# has_many :user_favorite_microposts
# has_many :favorite_microposts, through: :user_favorite_microposts, source: :micropost


# お気に入りツイート追加
# def add_favorite(micropost)
#   user_favorite_microposts.create(micropost_id: micropost.id)
# end

def add_favorite(micropost)
  user_favorite_microposts.find_or_create_by(micropost_id: micropost.id)
end

# お気に入りツイート削除
def remove_favorite(micropost)
  user_favorite_micropost = user_favorite_microposts.find_by(micropost_id: micropost.id)
  user_favorite_micropost.destroy if user_favorite_micropost.present?
end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end