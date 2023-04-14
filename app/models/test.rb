class Test < ApplicationRecord
  has_many :user_tests
  has_many :users, through: :user_tests

  def self.get_tests_name(category_name)
    Test.joins('join categories on categories.id = tests.category_id').where(categories: { title: category_name }).order(title: :DESC).pluck('tests.title')
  end
end
