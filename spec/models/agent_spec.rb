require 'rails_helper'

describe Agent do
  it 'is valid with a user, name of 3 chars and integer status' do
    agent = build(:agent)
    expect(agent).to be_valid
  end

  it 'is invalid with no user, name of 3 chars and integer status' do
    agent = build(:agent, user: nil)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, no name and integer status' do
    agent = build(:agent, name: nil)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name but no integer status' do
    agent = build(:agent, status: nil)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 2 chars and integer status' do
    agent = build(:agent, name: 'AA')
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 51 chars and integer status' do
    agent = build(:agent, name: 'A' * 51)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 3 chars and non-integer status' do
    agent = build(:agent, status: 'A')
    expect(agent).to be_invalid
  end

  it 'belongs to current user' do
    current_user = create(:user)
    agent = create(:agent, user: current_user)
    expect(Agent.belongs_to_current_user(current_user)).to eq [agent]
  end

  it 'does not belong to current user' do
    current_user = create(:user)
    agent = create(:agent,
      user: create(:user, email: 'user2@example.com'),
    )
    agents = Agent.belongs_to_current_user(current_user)
    expect(agents.first).not_to eq agent
  end

end
