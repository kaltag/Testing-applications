class Feedback
  include ActiveModel::Model

  attr_accessor :email, :text

  validates :email, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :text, presence: true

  def id
    nil
  end
end
