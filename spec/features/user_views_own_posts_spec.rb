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
    current_user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: current_user.email
    fill_in 'Password', with: current_user.password
    click_button 'Sign In'
    click_link 'My Posts'

    post = FactoryGirl.create(:post)
    post.user_id = current_user.id

    visit user_posts_path(current_user)

    expect(page).to have_content('Random Acts of Kindness')
    expect(page).to have_content('Title')
    expect(page).to have_content('Description')
    expect(post.user_id).to eq(current_user.id)
    current_path.should eq(user_posts_path(current_user))
  end

  scenario 'while not logged in' do
    current_user = FactoryGirl.create(:user)
    visit user_posts_path(current_user)

    expect(page).to_not have_content('Random Acts of Kindness')
    expect(page).to_not have_content('Title')
    expect(page).to_not have_content('Description')
  end
end
