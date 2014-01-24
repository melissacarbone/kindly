require "spec_helper"

feature 'User signs out' do
  # As a User
  # I want to sign out
  # So that my account information stays secure

  # ACCEPTANCE CRITERIA
  # *I must see a link to sign out
  # *When I sign out I will see a link to sign in
  # *When I am signed out I will not have access to my account information

  scenario 'authenticated user signs out' do
    current_user = FactoryGirl.create(:user)
    sign_in(current_user)
    click_link 'Sign Out'

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Signed Out Successfully.")
    expect(page).to_not have_content("Sign Out")
  end
end
