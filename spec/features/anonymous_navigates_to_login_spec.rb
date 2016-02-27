require 'rails_helper'

feature 'anonymous navigates to login' do
  scenario 'successfully' do  
    visit root_path
    click_link('Login')
    expect(current_path).to eq new_user_session_path
    expect(page).to have_css 'h2', text: 'Log in' 
  end
end