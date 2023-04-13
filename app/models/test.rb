class Test < ApplicationRecord
  has_and_belongs_to_many :users

  def self.get_tests_name(category_name)
    Test.joins('join categories on categories.id = tests.category_id').where(categories: { title: category_name }).order(title: :DESC).pluck('tests.title')
  end
end
