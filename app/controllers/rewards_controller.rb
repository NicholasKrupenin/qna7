class RewardsController < ApplicationController
  before_action :authenticate_user!

  def check_reward
    # binding.pry
    if current_user.available_reward.present?
      @answer_rewards = current_user.available_reward
    else
      render plain: "No rewards"
    end
  end
end
