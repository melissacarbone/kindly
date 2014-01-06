require 'spec_helper'

feature 'User sends a contact form' do
  scenario 'with all required and valid fields' do
    visit 'contacts/new'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Subject', with: 'Hello'
    fill_in 'Description', with: 'I like this site.'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    click_button 'Send Form'

    expect(page).to have_content('Form was successfully submitted.')

  end

end
