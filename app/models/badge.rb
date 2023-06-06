class Badge < ApplicationRecord
  enum rule: { category_complete: 0, first_attempt: 1, easy_tests: 2, medium_tests: 3, hard_tests: 4 }

  has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards

  validates :name, :rule, presence: true
end
