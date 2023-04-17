class Answer < ApplicationRecord
  belongs_to :question

  scope :correct_answer, -> { where(correct: true) }

  validates :body, presence: true

  validate :validate_answer_count

  def validate_answer_count
    errors.add(:question, 'too many answers') if question.answers.count != (1..4)
  end
end
