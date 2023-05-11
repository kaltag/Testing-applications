class Admin::GistsController < Admin::BaseController
  before_action :set_test_passage, only: %i[create]

  def index
    @gists = Gist.all
  end

  def create
    client = Octokit::Client.new(access_token: GitHubClient::GitHubToken)
    result = GistQuestionService.new(@test_passage.current_question, client:).call

    if client.last_response.status == 201
      redirect_to @test_passage, notice: t('.success', gist_url: result[:html_url]).html_safe
      Gist.create(user_id: current_user.id, question_id: @test_passage.current_question.id, gist_url: result[:html_url].html_safe)
    else
      redirect_to @test_passage, alert: t('.falure')
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
