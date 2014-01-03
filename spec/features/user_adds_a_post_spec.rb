require 'spec_helper'

feature 'User adds a post' do
  # As an authenticated user
  # I want to input an act of kindness that I completed
  # So that it can be recorded for later viewing

  # *I will be required to select a date, category, and enter a  title and text description of the activity.
  # *If I do not include all required fields, I will not be able to save my activity and I will be presented with an error message.
  # *If I complete all required fields I will be able to save my activity for later viewing.
  scenario 'an authenticated user adds a post with valid attributes' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Share some kindness!'
    fill_in 'Title', with: 'Coffee Surprise'
    fill_in 'Description', with: 'Paid for the person behind me at Starbucks.'
    fill_in 'Date', with: '2014-1-1'
    click_button 'Share'

    expect(page).to have_content('Success!')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content('Title')
    expect(page).to have_content('Description')
  end

  scenario 'an authenticated user adds a post with invalid attributes' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Share some kindness!'
    click_button 'Share'

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Date can't be blank")
    expect(page).to_not have_content('Success!')
  end

  scenario 'as an unauthenticated user' do
    visit 'posts/new'

    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
    expect(page).to_not have_content('Title')
    expect(page).to_not have_content('Description')


  end
end
