require 'rails_helper'

RSpec.shared_examples 'voteable' do |model_type|
  describe 'concern method' do
    let!(:vote) { create(:vote, choice: true, user: user, voteable: object) }

    context "#{model_type}#voted?" do
      it 'be true' do
        expect(object.voted?(user)).to be_truthy
      end

      it 'be false' do
        expect(object.voted?(another_user)).to_not be_truthy
      end
    end

    context "#{model_type}#find_vote" do
      it 'be find' do
      expect(object.find_vote(user)).to eq vote
      end

      it 'be not find' do
        expect(object.find_vote(another_user)).to be_nil
      end
    end

    context "#{model_type}#rating_votes" do
      it 'positive rating (1)' do
        expect(object.rating_votes).to eq 1
      end
    end
  end

  context "#{model_type}#rating_votes" do
    let!(:vote) { create_list(:vote, 2, choice: false, user: user, voteable: object) }

    it 'negative rating (-2)' do
      expect(object.rating_votes).to eq -2
    end
  end
end
