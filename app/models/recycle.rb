class Recycle < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :recycle_categories, dependent: :destroy


  def month
    created_at.month
  end


  def year
    created_at.year
  end

end
