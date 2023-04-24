module ApplicationHelper
  include BetterHtml::Helpers

  def current_year
    Time.zone.now.year
  end

  def github_ulr(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end
end
