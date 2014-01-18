require 'spec_helper'

feature 'User views recent posts from other users', %Q{
  As an authenticated user
  I want to view recent posts from other users
  So that I can gain inspiration for random acts of kindness
} do

  scenario 'while signed in' do
    current_user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: current_user.email
    fill_in 'Password', with: current_user.password
    click_button 'Sign In'

    visit user_posts_path(current_user)
    click_link 'Recent Posts'

    expect(page).to have_content('Recent Random Acts of Kindness')
    expect(page).to_not have_content('My Random Acts of Kindness')

  end

  scenario 'while not signed in' do
    current_user = FactoryGirl.create(:user)
    visit user_posts_path(current_user)

    expect(page).to_not have_content('My Posts')
    expect(page).to_not have_content('Recent Random Acts of Kindness')
    expect(page).to have_content('Sign In')
  end
end
