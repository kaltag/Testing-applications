class Feedback < ApplicationRecord
  validates :email, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :text, presence: true
end
