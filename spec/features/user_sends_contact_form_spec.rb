require 'spec_helper'

feature 'User sends a contact form' do
  scenario 'with all required and valid fields' do
    ActionMailer::Base.deliveries = []
    visit root_path
    click_link 'Contact Us!'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Subject', with: 'Hello'
    fill_in 'Description', with: 'I like this site.'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    click_button 'Send Form'

    expect(page).to have_content('Form was successfully submitted.')
    expect(page).to have_content("We'd love to hear from you...")
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

  scenario 'with invalid attributes' do

    visit root_path
    click_link 'Contact Us!'
    click_button 'Send Form'

    expect(page).to have_content('Email is invalid')
    expect(page).to have_content('Subject can\'t be blank')
    expect(page).to have_content('Description can\'t be blank')
    expect(page).to have_content('First name can\'t be blank')
    expect(page).to have_content('Last name can\'t be blank')
    expect(page).to_not have_content('Form was successfully submitted.')

  end

end
