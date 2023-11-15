require 'rails_helper'

feature 'User can create question', %{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit root_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Text text text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
    end

    scenario 'ask a question with errors' do
      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with attached file' do
      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'text text text'

      attach_file('question[files][]', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"])

      click_on 'Ask'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'asks a question with an award ' do
      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'text text text'
      fill_in 'Regard name', with: 'space'

      attach_file('question[regard_attributes][pic]', "#{Rails.root}/app/assets/images/space.jpg")

      click_on 'Ask'
      expect(page).to have_content 'space'
      expect(page.find('img')['src']).to match(/space.jpg/)
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit root_path

    expect(page).not_to have_link 'Ask question'
  end
end
