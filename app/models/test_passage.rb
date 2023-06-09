class TestPassage < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question, on: %i[create update]
  # before_update :before_save_check_success

  SUCCESPOINT = 85

  def completed?
    current_question.nil?
  end

  def success?
    percent >= SUCCESPOINT && !time_is_up?
  end

  def percent
    (correct_question.to_f / test.questions.count) * 100
  end

  def progress
    (current_question_number.to_f / test.questions.count) * 100
  end

  def accept!(answer_ids)
    self.correct_question += 1 if correct_answer?(answer_ids) && !time_is_up?
    self.success = success?

    save!
  end

  def current_question_number
    current_question_index + 1
  end

  def timer_finish_time
    created_at + test.timer.minutes
  end

  def time_is_up?
    test.timer? && timer_finish_time.past?
  end

  private

  def before_validation_set_question
    self.current_question = if current_question.present?
                              next_question
                            else
                              test.questions.first
                            end
  end

  # def before_save_check_success
  #   self.success = true if success?
  # end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct_answer
  end

  def current_question_index
    test.questions.index(current_question)
  end
end
