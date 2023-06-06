class UserRewardsController < ApplicationController
  def index
    @my_rewards = current_user.user_rewards.includes(:badge)
    @no_received_rewards = Badge.all - @my_rewards.map(&:badge)
  end
end
