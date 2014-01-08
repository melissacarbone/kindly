require 'spec_helper'

feature 'User signs in' do
  # As a user
  # I want to sign in
  # So that I can track my random acts of kindness

  # ACCEPTANCE CRITERIA
  # *If I specify a valid, previously registered email and password, I am authenticated and I gain access to the system.
  # *If I specify an invalid email address or password, I remain unauthenticated.
  # *If I am already signed in, I cannot sign in again.
  # *I must be directed to my index page when I sign into my account.

  scenario 'an existing user specifies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')
    current_path.should eq(posts_path)
  end

  scenario 'a nonexistent email and password is supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: 'Incorrect Password'
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path
    expect(page).to have_content('You are already signed in.')
  end

end
