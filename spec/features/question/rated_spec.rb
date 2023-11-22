require 'rails_helper'

feature 'A user can rate a question that is not their own', %{
  In order to find the question is interested
  I want to be able to view all rated questions
} do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:questions) { create(:question, user: another_user) }

  describe 'Authenticated user', js: true do
    scenario 'rated question' do
      sign_in(user)

      visit root_path
      click_on 'like'

      within '.rating' do
        expect(page).to have_content '1'
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'don\'t rated question' do
      sign_in(another_user)
      visit root_path

      expect(page).to_not have_link 'like'
    end
  end
end
