require 'rails_helper'

feature 'User can select best answer', %q{
  As an author of question
  I'd like ot be able to select another best answer
} do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:another_answer) { create(:answer, :another, question: question, user: another_user) }

  scenario 'Unauthenticated can not select best answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Add star'
  end

  describe 'Authenticated user', js: true do
    given!(:answer) { create(:answer, question: question, user: user) }

    scenario 'selected best answer created by author' do
      sign_in(user)
      visit question_path(question)

      within ".answer-id-#{answer.id}" do
        click_on 'Add star'
      end

      within '.best' do
        expect(page).to have_content 'Best answer:'
        expect(page).to have_content answer.body
        expect(page).to_not have_link 'Add star'
      end
    end

    scenario 'selected best answer created by another' do
      sign_in(user)
      visit question_path(question)

      within ".answer-id-#{another_answer.id}" do
        click_on 'Add star'
      end

      within '.best' do
        expect(page).to have_content 'Best answer:'
        expect(page).to have_content another_answer.body
        expect(page).to_not have_link 'Add star'
      end
    end

    scenario 'Not the author of the question cannot choose the best answer' do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_link 'Add star'
      expect(page).to_not have_link 'Add star'
    end
  end
end
