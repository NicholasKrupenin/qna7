module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_voteable, only: %i[vote_like vote_dislike]
  end

  def vote_like
    vote(true)
  end

  def vote_dislike
    vote(false)
  end

  def deselect
    @voteable.find_vote(current_user).destory
  end

  private

  def vote(arg)
    if @voteable.voted?
      @vote = @voteable.find_vote(current_user)
      @vote.update(choice: arg) if @vote.choice != arg
    else
      @vote = @voteable.votes.new(user_id: current_user, choice: arg)
      @vote.save
    end
    respond_to do |format|
      format.json { render json: { vote: @vote, rating: @voteable.rating_votes } }
    end
  end

  def model_klass
    controller_name.classify.constantize
  end

  def set_voteable
    @voteable = model_klass.find(params[:id])
  end
end
