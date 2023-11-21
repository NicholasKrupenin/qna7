module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :voteable
  end

  def voted?(user)
    votes.find_by(user_id: user.id).present?
  end

  def find_vote(user)
    votes.find_by(user_id: user)
  end

  def rating_votes
    like_votes = votes.where(choice: true).count
    dislike_votes = votes.where(choice: false).count
    like_votes - dislike_votes
  end
end
