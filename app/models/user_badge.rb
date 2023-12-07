class UserBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user

  validates :badge, uniqueness: { scope: :user }

end
