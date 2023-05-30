class User < ApplicationRecord
  # :lockable, :timeoutable, and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy

  has_many :gists, dependent: :destroy
  has_many :questions, through: :gists, dependent: :destroy

  has_many :user_rewards
  has_many :badges, through: :user_rewards

  has_many :created_tests, class_name: 'Test', dependent: :destroy

  def get_tests_with_level(level)
    tests.where(level:)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
