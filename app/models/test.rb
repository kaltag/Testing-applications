class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :test_passages
  has_many :users, through: :test_passages
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  scope :easy_tests, -> { where(level: 0..1) }
  scope :medium_tests, -> { where(level: 2..4) }
  scope :hard_tests, -> { where(level: 5..Float::INFINITY) }

  scope :get_tests_category, ->(category_name) { Test.joins(:category).where(categories: { title: category_name }) }

  validates :title, presence: true
  validates :level, presence: true
  validates :title, uniqueness: { scope: :level }
  validates_numericality_of :level, greater_than_or_equal_to: 0

  def self.get_tests_name(category_name)
    Test.get_tests_category(category_name).order(title: :DESC).pluck('tests.title')
  end
end
