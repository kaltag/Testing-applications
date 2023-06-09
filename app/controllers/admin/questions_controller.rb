class Admin::QuestionsController < Admin::BaseController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_test, only: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show
  end

  def new
    @question = @test.questions.new
  end

  def edit
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to admin_question_path(@question), notice: t('.question_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: t('.question_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(id: @question.test_id), notice: t('.question_deleted')
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
    # render file: 'public/404', layout: false, status: :not_found
    render plain: 'Вопрос не найден'
  end
end
