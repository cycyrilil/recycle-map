class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :favorites, dependent: :destroy
  has_many :place_categories, dependent: :destroy
  has_many :recycles, dependent: :destroy
end
