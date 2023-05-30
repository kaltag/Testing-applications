class UserRewardsController < ApplicationController
  def index
    @my_rewards = current_user.user_rewards
    @no_received_rewards = Badge.all - @my_rewards.map(&:badge)
  end
end
