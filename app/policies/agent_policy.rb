class AgentPolicy < ApplicationPolicy
  def index?
    true
  end
  def create?
    true
  end
  def update?
    @record.user_id == @user.id
  end
  def destroy?
    update?
  end
end
