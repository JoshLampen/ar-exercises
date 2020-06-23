class Store < ActiveRecord::Base
  has_many :employees

  validates :name, length: { minimum: 3 }
  validates :annual_revenue, numericality: { only_integer: true, greater_than: 0 }
  validate :must_have_mens_or_womens_apparel

  before_destroy :destroyable?

  def must_have_mens_or_womens_apparel
    if !mens_apparel.present? && !womens_apparel.present?
      errors.add(:mens_apparel, "must sell either mens or womens apparel")
    end
  end

  def destroyable?
    if Employee.where(store_id: self.id).size > 0
      false
    end
  end
end
