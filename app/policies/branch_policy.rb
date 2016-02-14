class BranchPolicy < ApplicationPolicy
  # Means all users can execute the index function
  def index?
    true
  end
  # Means all users can execute the json function
  def json?
    true
  end
  # Covers new and means that all logged in users can see the
  # create new branch form
  def new?
    true
  end
  # Covers create and means that a branch can be created if the agent chosen
  # in the dropdown belongs to the current user
  def create?
    Agent.belongs_to_current_user(@user).exists?(@record.agent_id)
  end
  # Covers edit and means that a branch information can be displayed if the
  # branch belongs to the current user via the agent_id field on the branch
  def edit?
    Branch.belongs_to_current_user(@user).exists?(@record.id)
  end
  # Covers update and means that a branch can be updated if the branch belongs
  # to the current user and if the agent chosen in the dropdown belongs to the
  # current user
  def update?
    branch = Branch.belongs_to_current_user(@user).exists?(@record.id)
    agent = Agent.belongs_to_current_user(@user).exists?(@record.agent_id)
    branch && agent ? true : false
  end
  # Covers destroy and means that a branch can be destroyed if it belongs to the
  # current user
  def destroy?
    Branch.belongs_to_current_user(@user).exists?(@record.id)
  end
end
