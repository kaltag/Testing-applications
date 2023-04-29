module ApplicationHelper
  include BetterHtml::Helpers

  def current_year
    Time.zone.now.year
  end

  def github_ulr(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end

  def flash_message
     if flash[:alert]
       content_tag :p, flash[:alert], class: 'flash alert'
     end
  end
end
