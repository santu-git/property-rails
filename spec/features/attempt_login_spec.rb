require 'rails_helper'

feature 'attempt to login' do
  scenario 'successfully' do
    # Setup
    create(:user, email: 'user@example.com', password: 'password')
    # Exercise
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Log in'
    # Verify
    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully'
  end	
end