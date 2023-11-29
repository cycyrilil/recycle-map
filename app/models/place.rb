class Place < ApplicationRecord
  geocoded_by :adress
  after_validation :geocode, if: :will_save_change_to_adress?
  has_many :favorites, dependent: :destroy
  has_many :place_categories, dependent: :destroy
  has_many :recycles, dependent: :destroy
end
