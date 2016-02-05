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
    #Agent.belongs_to_current_user(@user).exists?(@record.agent_id)
    false
  end
  def update?
    false
  end
  def destroy?
    update?
  end
end
