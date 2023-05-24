class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.valid?
      FeedbacksMailer.completed_feedback(@feedback).deliver_now
      redirect_to root_path, notice: t('.success')
    else
      render :new
    end
  end

  private

  def feedback_params
    params.permit(:email, :text)
  end
end
