class User < ActiveRecord::Base
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
end