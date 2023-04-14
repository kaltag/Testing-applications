class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests
  belongs_to :user

  def self.get_tests_name(category_name)
    Test.joins('join categories on categories.id = tests.category_id').where(categories: { title: category_name }).order(title: :DESC).pluck('tests.title')
  end
end
