module ApplicationHelper
  def current_year
    Time.zone.now.year
  end

  def github_ulr(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end

  def flash_message
    flash.each do |type, msg|
      content_tag :p, msg, class: "flash #{type}"
    end
  end
end
