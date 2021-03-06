require 'spec_helper'

feature 'User adds a post' do
  # As an authenticated user
  # I want to input an act of kindness that I completed
  # So that it can be recorded for later viewing

  # *I will be required to select a date, category, and enter a  title and text Details of the activity.
  # *If I do not include all required fields, I will not be able to save my activity and I will be presented with an error message.
  # *If I complete all required fields I will be able to save my activity for later viewing.
  # *If I am not signed in I cannot add posts
  # *My posts should be associated with my account

  scenario 'an authenticated user adds a post with valid attributes' do
    category1 = Category.create(name: 'Community')
    category2 = Category.create(name: 'Family')
    current_user = FactoryGirl.create(:user)
    sign_in(current_user)

    click_link 'Share some kindness!'
    fill_in 'Title',          with: 'Coffee Surprise'
    fill_in 'Details',        with: 'Paid for the person behind me at Starbucks.'
    select category1.name,    from: 'Category'
    click_button 'Share'

    expect(page).to have_content('Post was successfully submitted!')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content('Title')
    expect(page).to have_content('Details')
    expect(page).to have_content('Category')
    expect(Post.all.count).to eq(1)
    current_path.should eq(posts_path)
  end

  scenario 'an authenticated user adds a post with invalid attributes' do
    category = Category.create(name: 'Community')
    current_user = FactoryGirl.create(:user)
    sign_in(current_user)

    click_link 'Share some kindness!'
    click_button 'Share'

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to_not have_content('Post was successfully submitted!')
  end

  scenario 'as an unauthenticated user' do
    visit 'posts/new'

    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
    expect(page).to_not have_content('Title')
    expect(page).to_not have_content('Details')

  end
end
