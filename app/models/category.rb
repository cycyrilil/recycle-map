class Category < ApplicationRecord
  has_many :badges, dependent: :destroy
  has_many :recycle_categories, dependent: :destroy
end
