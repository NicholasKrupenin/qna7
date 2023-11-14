require 'rails_helper'

feature 'User can receive rewards', %{
  In order to get feedback
  As an authenticated user
  I'd like to be able to view awards
} do

  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:regard) { create(:regard, question: question) }
  given!(:answer) { create(:answer, question: question, user: another_user) }
  given!(:answers) { create_list(:answer, 2, question: question, user: another_user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)

      within ".answer-id-#{answer.id}" do
        click_on 'Add star'
      end
    end

    scenario 'another user receive reward' do

      click_button 'Sign out'
      sign_in(another_user)
      visit reward_path

      expect(page).to have_content question.title
      expect(page).to have_content 'Your reward'
      expect(page.find('img')['src']).to match(/space.jpg/)
    end

    scenario 'another user receive single reward for selecting multiple answers (add_star)' do

      answers.each do |answer|
        within ".answer-id-#{answer.id}" do
          click_on 'Add star'
        end
      end

      click_button 'Sign out'
      sign_in(another_user)
      visit reward_path

      expect(page).to have_content question.title, maximum: 1
      expect(page).to have_content 'Your reward', maximum: 1
      expect(page).to have_css 'img', maximum: 1
    end

    scenario 'user not receive reward' do
      visit reward_path

      expect(page).to_not have_content question.title
      expect(page).to_not have_content 'Your reward'
      expect(page).to_not have_css 'img'
    end
  end

  describe 'An unauthenticated user' do
    scenario 'cannot show reward' do
        visit question_path(question)

        expect(page).not_to have_link 'My reward'
      end
    end
end
