class RecycleCategory < ApplicationRecord
  belongs_to :category
  belongs_to :recycle

  after_create :assign_badge

  private

  def assign_badge
    RecycleCategory.where(recycle_id: self.recycle_id).each do |recycle_category|
      badge = Badge.find_by(category: recycle_category.category)
      p "========================"
      p "je passe"
      p "========================"
      if badge && badge.unlock_number == recycle_category.recycle.user.recycle_categories.where(category: recycle_category.category).count
        UserBadge.create!(user: recycle_category.recycle.user, badge: badge)
      end
    end
  end
end
