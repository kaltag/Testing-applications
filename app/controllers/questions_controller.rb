class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy]
  before_action :set_test, only: %i[index new]

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
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to test_questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    render plain: 'Question has been deleted successfully!'

    # respond_to do |format|
    #   format.html { redirect_to test_questions_path, notice: "Question was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body, :test_id)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден'
  end
end
