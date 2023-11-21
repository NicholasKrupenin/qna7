require 'rails_helper'
shared_examples_for 'voteable' do
  context '#methods' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:vote_like) { create(:vote_like, choice: true, user: user) }

    it 'one' do
      pp vote_like
    end
  end
end
