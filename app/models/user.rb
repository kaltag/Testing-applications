class User < ApplicationRecord
  has_and_belongs_to_many :tests
  def get_tests_with_level(level)
    tests.where(level:)
  end
end
