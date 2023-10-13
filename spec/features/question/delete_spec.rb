require 'rails_helper'

feature 'User can only delete his question', %{
  To get a new response from the community
  As an authenticated user
  I would like to be able to delete my question
} do

  given(:user) { create(:user) }
  given(:user_not_author) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }

  scenario 'Authenticated user delete his question', js: true do
    sign_in(user)
    visit root_path
    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully delete.'
  end

  scenario 'Authenticated user is trying to delete question that is not their own' do
    sign_in(user_not_author)
    visit question_path(question)

    expect(page).to_not have_link 'Delete question'
  end

  scenario 'Authenticated user and owner of the answer delete attach files', js: true do
    question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: "rails_helper.rb")
    sign_in(user)
    visit root_path

    expect(page).to have_link 'Delete'
  end

  scenario 'Authenticated user and not owner of the answer delete attach files', js: true do
    question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: "rails_helper.rb")
    sign_in(user_not_author)
    visit root_path

    expect(page).to_not have_link 'Delete'
  end
end
