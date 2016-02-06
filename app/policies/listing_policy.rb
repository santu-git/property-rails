class ListingPolicy < ApplicationPolicy
  def index?
    true
  end
  def new?
    true
  end
  def create?
    # TODO these are nasty
    Branch.belongs_to_current_user(@user).exists?(@record.branch_id)
  end
  def update?
    Branch.belongs_to_current_user(@user).exists?(@record.branch_id)
  end
  def destroy?
    update?
  end
end
