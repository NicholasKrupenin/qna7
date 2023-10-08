require 'rails_helper'

feature 'User can write the answer on the question page', %q{
  To help with a question
  As an authenticated user
  I would like to be able to write an answer
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit questions_path
      click_on question.title
    end

    scenario 'write an answer' do
      fill_in 'Body', with: 'Text answer'
      click_on 'Create answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'Text answer'
    end

    scenario 'write an answer with errors' do
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'An unauthenticated user' do
    scenario 'cannot create a answer' do
      visit question_path(question)

      expect(page).not_to have_button 'Create answer'
    end
  end

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'My answer'
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'Authenticated user creates answer with errors', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end
end
