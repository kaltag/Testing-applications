class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: 'Test'

  VALID_EMAIL= /\A\w+@\w+\.\w+\z/

  validates :email, presence: true,
                    format: VALID_EMAIL,
                    uniqueness: { case_sensitive: false }

  has_secure_password

  def get_tests_with_level(level)
    tests.where(level:)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
