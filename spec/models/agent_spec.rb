require 'rails_helper'

describe Agent do
  it 'is valid with a user, name of 3 chars and integer status' do
    agent = Agent.new(user: create(:admin), name: 'AAA', status: 1)
    expect(agent).to be_valid
  end

  it 'is invalid with no user, name of 3 chars and integer status' do
    agent = Agent.new(user: nil, name: 'AAA', status: 1)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, no name and integer status' do
    agent = Agent.new(user: create(:admin), name: nil, status: 1)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 3 chars and no integer status' do
    agent = Agent.new(user: create(:admin), name: 'AAA', status: nil)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 2 chars and integer status' do
    agent = Agent.new(user: create(:admin), name: 'AA', status: 1)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 51 chars and integer status' do
    agent = Agent.new(user: create(:admin), name: 'A' * 51, status: 1)
    expect(agent).to be_invalid
  end

  it 'is invalid with a user, name of 3 chars and non-integer status' do
    agent = Agent.new(user: create(:admin), name: 'AAA', status: 'A')
    expect(agent).to be_invalid
  end

  it 'belongs to current user' do
    current_user = create(:user)
    agent = Agent.create(user: current_user, name: 'AAA', status: 1)
    expect(Agent.belongs_to_current_user(current_user)).to eq [agent]
  end

  it 'does not belong to current user' do
    current_user = create(:user)
    agent = Agent.create(
      user: create(:user, email: 'user2@example.com'),
      name: 'AAA',
      status: 1
    )
    agents = Agent.belongs_to_current_user(current_user)
    expect(agents.first).not_to eq agent
  end

end
