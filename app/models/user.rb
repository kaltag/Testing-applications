class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :tests

  def get_tests_with_level(level)
    tests.where(level:)
  end
end
