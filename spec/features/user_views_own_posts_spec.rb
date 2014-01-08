require 'spec_helper'

feature 'User views their own posts', %Q{
  As an authenticated user
  I want to see which random acts of kindness I've completed
  So that I can plan my next activity
} do

  # ACCEPTANCE CRITERIA
  # *I must be able to view the title, description, and date of all completed activities.
  # *I should not be able to view my posts if I am not signed in.

  scenario 'while signed in' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    post = FactoryGirl.create(:post)
    post.user_id = user.id

    visit posts_path

    expect(page).to have_content('My Random Acts of Kindness')

    expect(page).to have_content('Title')
    expect(page).to have_content('Date')
    expect(post.user_id).to eq(user.id)
  end

  scenario 'while not logged in'
end
