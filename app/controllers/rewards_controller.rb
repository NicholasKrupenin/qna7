class RewardsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def check_reward
    if current_user.available_reward.present?
      @answer_rewards = current_user.available_reward
    else
      render plain: "No rewards"
    end
  end
end
