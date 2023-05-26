class TestsController < ApplicationController
  before_action :set_test, only: %i[start]

  def index
    # 1 вариант

    # questions_with_answ = Question.joins(:answers).distinct
    # @correct_tests = questions_with_answ.map{&:test}.uniq.sort

    # 2 вариант
    @correct_tests = Question.joins(:answers).distinct.map(&:test).uniq.sort
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
end
