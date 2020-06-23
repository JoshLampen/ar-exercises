class Employee < ActiveRecord::Base
  belongs_to :store

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hourly_rate, inclusion: { in: 40...200 }
  validates :hourly_rate, numericality: { only_integer: true }
  validates :store_id, presence: true

  before_create :generate_password

  private

  def generate_password
    self.password = ('0'..'z').to_a.shuffle.first(8).join
  end
end
