module Features
  module SessionHelpers
    def sign_up
      visit root_path
      click_link 'Sign Up'
      fill_in 'First Name',           with: 'Jane'
      fill_in 'Last Name',            with: 'Smith'
      fill_in 'E-mail',               with: 'user@example.com'
      fill_in 'user_password',        with: 'password'
      fill_in 'Password Confirmation',with: 'password'
      attach_file 'Image', Rails.root.join('spec/file_fixtures/example_image.jpg')
      click_button 'Sign Up'
    end

    def sign_in
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in 'E-mail',               with: user.email
      fill_in 'Password',             with: user.password
      click_button 'Sign In'
    end

    def create_post
      category = Category.create(name: 'Community')
      click_link 'Share some kindness!'
      fill_in 'Title',                with: 'Coffee Surprise'
      fill_in 'Details',              with: 'Paid for the person behind me at Starbucks.'
      fill_in 'Location',             with: 'New York'
      select 'Community',             from: 'Category'
      click_button 'Share'
    end
  end
end
