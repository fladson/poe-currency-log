class UserSetting < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :currency, scope: [:user_id]

  scope :ordered, -> { order(:sort) }
end
