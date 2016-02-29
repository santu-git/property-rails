require 'rails_helper'

describe User do
  it 'is an administrative user' do
    user = create(:admin)
    expect(user.is_admin?).to eq true
  end
  it 'is a normal user' do
    user = create(:user)
    expect(user.is_admin?).to eq false
  end
end
