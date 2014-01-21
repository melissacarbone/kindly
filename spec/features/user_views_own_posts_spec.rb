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

    expect(page).to have_content('My Random Acts of Kindness')
    expect(page).to have_content('Title')
    expect(page).to have_content('Details')
    expect(post.user_id).to eq(current_user.id)
    current_path.should eq(user_posts_path(current_user))
    expect(page).to have_content('Recent Posts')
    expect(page).to_not have_content('Recent Random Acts of Kindness')
  end

  scenario 'while not logged in' do
    current_user = FactoryGirl.create(:user)
    visit user_posts_path(current_user)

    expect(page).to_not have_content('Random Acts of Kindness')
    expect(page).to_not have_content('Title')
    expect(page).to_not have_content('Description')
  end

  scenario 'authenticated user views descendants of post' do
    current_user = FactoryGirl.create(:user)
    sign_in
    parent_post = create_post
    parent_post.user_id = current_user.id
    child_post = FactoryGirl.create(:post, parent: parent_post)
    click_link "My Posts"

    expect(page).to have_content('This post inspired 1 act of kindness')
    expect(page).to have_content(Post.find(child_post.parent_id).email)


  end
end
