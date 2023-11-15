require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user ) }

  describe 'Authenticated user' do

    before do
      question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: "rails_helper.rb")
      question.files.attach(io: File.open("#{Rails.root}/spec/spec_helper.rb"), filename: "spec_helper.rb")
    end

    it 'Delete file' do
      login(user)
      expect { delete :destroy, params: { id: question.files.first.id }, format: :js }.to change(question.files, :count).by(-1)
    end

    it 'Render view' do
      login(user)
      delete :destroy, params: { id: question.files.first.id }, format: :js
      expect(response).to render_template :destroy
    end

    it 'Delete file another user' do
      login(create(:user))
      expect { delete :destroy, params: { id: question.files.first.id }, format: :js }.to change(question.files, :count).by(0)
    end
  end
end