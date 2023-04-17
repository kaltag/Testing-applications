class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :my_test, class_name: 'Test'

  def get_tests_with_level(level)
    tests.where(level:)
  end
end
