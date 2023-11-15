require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given(:gist_url) {'https://gist.github.com/NicholasKrupenin/8df1feb56ab0cb33422823f77c940fc4'}
  given(:url) { 'https://www.google.com' }


  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'My answer'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: url

    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: url
    end
  end

  scenario 'User adds gist link when write answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'My answer'
    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Create answer'

    visit question_path(question)

    within '.answers' do
      expect(page.find('code')['data-gist-id']).to eq '8df1feb56ab0cb33422823f77c940fc4'
      expect(page).to have_content '<h1>List of questions </h1>'
    end
  end
end
