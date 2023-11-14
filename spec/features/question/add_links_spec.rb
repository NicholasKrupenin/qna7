require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/NicholasKrupenin/8df1feb56ab0cb33422823f77c940fc4' }
  given(:url) { 'https://www.google.com' }

  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit root_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: url
  end

  scenario 'User adds gist link when asks question', js: true do
    sign_in(user)
    visit root_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    visit root_path
    expect(page.find('code')['data-gist-id']).to eq '8df1feb56ab0cb33422823f77c940fc4'
    expect(page).to have_content '<h1>List of questions </h1>'
  end
end
