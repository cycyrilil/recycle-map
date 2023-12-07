class Recycle < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :recycle_categories, dependent: :destroy
  has_many :categories, through: :recycle_categories


  def month
    created_at.month
  end


  def year
    created_at.year
  end

  def day
    created_at.day
  end

  def self.month_name(month_number)
    Date::MONTHNAMES[month_number]
  end





end
