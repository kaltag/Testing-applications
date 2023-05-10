class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    client = Octokit::Client.new(access_token: GitHubClient::ACCESS_TOKEN)
    result = GistQuestionService.new(@test_passage.current_question, client:).call

    if result[:html_url]
      redirect_to @test_passage, notice: t('.success', gist_url: result[:html_url]).html_safe
      Gist.create(user_id: current_user.id, question_id: @test_passage.current_question.id, gist_url: result[:html_url].html_safe)
    else
      redirect_to @test_passage, alert: t('.falure')
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
