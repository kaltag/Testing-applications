class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy]
  before_action :set_test, only: %i[index new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
    render plain: @questions.inspect
  end

  def show
    render plain: @question.body
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_questions_path, notice: 'Question was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    render plain: 'Question has been deleted successfully!'

    # redirect_to test_questions_path, notice: "Question was successfully destroyed."
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден'
  end
end
