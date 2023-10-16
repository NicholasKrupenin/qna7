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

    scenario 'write an answer with attached file' do
      fill_in 'Body', with: 'Text answer'
      attach_file ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"] do
        find('input[name="answer[files][]"][id="answer_files"]').click
      end
      click_on 'Create answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'An unauthenticated user' do
    scenario 'cannot create a answer' do
        visit question_path(question)

        expect(page).not_to have_button 'Create answer'
      end
    end
end
