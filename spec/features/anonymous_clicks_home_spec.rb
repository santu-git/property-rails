require 'rails_helper'

feature 'anonymous clicks to return to home' do
  scenario 'successfully' do  
    visit root_path
    page.find('.navbar-brand').click
    expect(current_path).to eq root_path
  end
end