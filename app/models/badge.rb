class Badge < ApplicationRecord
  enum rule: { category: 0, first_attempt: 1, lvl_tests: 2 }

  has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards

  validates :name, :rule, presence: true
end
