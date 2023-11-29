class Recycle < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :recycle_categories, dependent: :destroy
end
