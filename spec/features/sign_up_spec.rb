require 'spec_helper'

feature 'User signs up' do
  # As a new user
  # I want to create an account
  # So that I can be inspired to increase my random acts of kindness

  # ACCEPTANCE CRITERIA
  # *I must specify an email, first name, last name, password, and password confirmation.
  # *If I do not specify required information, I will not be granted access to the site.
  # *If I specify all of the required information, my account will be created and I can track my random acts of kindness.

  scenario 'specifying valid and required information' do
    sign_up

    expect(page).to have_content('You have successfully created an account!')
    expect(page).to have_content('Sign Out')
    expect(User.last.image.url).to be_present
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match password' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'somethingDifferent'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
