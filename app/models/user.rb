class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_badges
  has_many :badges, through: :user_badges, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  has_many :favorites, dependent: :destroy
  has_many :recycles, dependent: :destroy
end
