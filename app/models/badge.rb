class Badge < ApplicationRecord
  enum rule: { category_complete: 0, first_attempt: 1, easy_tests: 2, medium_tests: 3, hard_tests: 4 }

  has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards

  before_save :set_image, if: :new_record?

  validates :name, :rule, presence: true

  private

  def set_image
    self.image = 'badge.png'
  end
end
