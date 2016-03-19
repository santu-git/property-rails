class AgentPolicy < ApplicationPolicy
  # Means all users can see the index function
  def index?
    true
  end
  # Means all users can see the json function
  def json?
    true
  end
  # Covers new and create methods and means logged in user can
  # create a new agent
  def create?
    true
  end
  # Covers edit and update methods and means logged in user
  # (checked via :authenticate_user!) can see a record to edit and update it
  # if the record belongs to them
  def update?
    @record.user_id == @user.id
  end
  # Means logged in user (checked via :authenticate_user!) can
  # destroy an agent if the record they want to destroy has the same
  # attributes as when editing / updating i.e. it belongs to their user
  def destroy?
    update?
  end
end
