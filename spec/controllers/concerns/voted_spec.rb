require 'rails_helper'

RSpec.shared_examples 'voted' do |controller_type|
  describe 'PUT #vote_like #vote_dislike' do
    before { login(user) }

    context 'create new vote' do
      it 'save a new vote in the database' do
        expect { put :vote_like, params: { id: object }, format: :json }.to change(Vote, :count).by(1)
      end

      it 'respond json' do
        put :vote_like, params: { id: object }, format: :json
        expect(JSON.parse(response.body)['vote']['voteable_id']).to eq object.id
      end
    end
  end

  context 'update vote' do
    let!(:vote) { create(:vote, choice: true, user: user, voteable: object) }
    before { login(user) }

    it 'update choice vote' do
      put :vote_dislike, params: { id: object }, format: :json
      expect(JSON.parse(response.body)['vote']['choice']).to be_falsey
    end
  end

  describe 'DELETE #deselect' do
    let!(:vote) { create(:vote, choice: true, user: user, voteable: object) }
    before { login(user) }

    it 'delete vote in the database' do
      expect { delete :deselect, params: { id: object }, format: :json }.to change(Vote, :count).by(-1)
    end
  end
end
