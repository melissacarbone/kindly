require 'spec_helper'

feature 'User edits a post' do

  scenario 'with required and valid attributes' do
    sign_in
    post = create_post

    click_link 'My Posts'
    click_link 'Edit'
    fill_in 'Title', with: 'Coffee'
    fill_in 'Details', with: 'Paid for coffee'
    select 'Community', from: 'Category'
    click_button 'Update'

    expect(page).to have_content('Updated Successfully!')
  end

  scenario 'with missing or invalid attributes' do
    sign_in
    post = create_post

    click_link 'My Posts'
    click_link 'Edit'
    fill_in 'Details', with: ''
    click_button 'Update'

    expect(page).to_not have_content('Updated Successfully!')
  end
end
