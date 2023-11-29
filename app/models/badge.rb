class Badge < ApplicationRecord
  belongs_to :category
  has_many :user_badges, dependent: :destroy
end
