class BranchPolicy < ApplicationPolicy
  def index?
    true
  end
  def json?
    true
  end
  def new?
    true
  end
  def create?
    # TODO These are nasty
    # You can create a branch if the agent you are associating the new agent
    # with belongs to your current user
    Agent.belongs_to_current_user(@user).exists?(@record.agent_id)
  end
  def update?
    # You can update a branch if the branch belongs to current user
    # (via agents join) and the branch exists for the id provided
    Branch.belongs_to_current_user(@user).exists?(@record.id)
  end
  def destroy?
    update?
  end
end
