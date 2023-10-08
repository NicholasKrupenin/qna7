require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do
  given!(:user) { create(:user) }
  given!(:another) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated can not edit question' do
    visit root_path

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    scenario 'edits his question' do
      sign_in(user)
      visit root_path
      click_on 'Edit'

      within '.questions' do
        fill_in 'Title', with: 'edited title'
        fill_in 'Body', with: 'edited body'
        click_on 'Save'

        expect(page).to have_content 'edited title'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his question with errors' do
      sign_in(user)
      visit root_path
      click_on 'Edit'

      within '.questions' do
        fill_in 'Title', with: ''
        fill_in 'Body', with: ''
        click_on 'Save'
      end

      expect(page).to have_content 'Body can\'t be blank'
      expect(page).to have_content 'Title can\'t be blank'
    end

    scenario "tries to edit other user's question" do
      sign_in(another)
      visit root_path

      expect(page).to_not have_link 'Edit'
    end
  end
end
