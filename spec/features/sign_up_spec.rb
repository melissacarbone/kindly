require 'spec_helper'

feature 'User signs up' do
  # As a new user
  # I want to create an account
  # So that I can be inspired to increase my random acts of kindness

  # ACCEPTANCE CRITERIA
  # *I must specify an email address, email confirmation, first name, last name, username, password, and password confirmation.
  # *If I do not specify required information, I will not be granted access to the site.
  # *If I specify all of the required information, my account will be created and I can track my random acts of kindness.

  scenario 'specifying valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Jane'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'E-mail', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content('You have successfully created an account!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information is not supplied'

  scenario 'password confirmation does not match password'



end
