require 'spec_helper'

feature 'User edits a post' do

  scenario 'with required and valid attributes' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'E-mail',         with: user.email
    fill_in 'Password',       with: user.password
    click_button 'Sign In'
    category = Category.create(name: 'Community')
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in "Title", with: 'Coffee'
    fill_in "Description", with: 'Paid for coffee'
    select category.name, from: 'Category'
    click_button 'Update'

    expect(page).to have_content('Updated!')
  end

  scenario 'with missing or invalid attributes'
end
