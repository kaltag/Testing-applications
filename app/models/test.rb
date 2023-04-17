class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  scope :correct_answer, -> { where(correct: true) }

  scope :easy_tests, -> { where(level: 0..1) }
  scope :medium_tests, -> { where(level: 2..4) }
  scope :hard_tests, -> { where(level: 5..Float::INFINITY) }

  scope :get_tests_name, ->(category_name) { Test.joins(:category).where(categories: { title: category_name }).order(title: :DESC).pluck('tests.title') }
end
