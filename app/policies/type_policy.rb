class TypePolicy < ApplicationPolicy
  # Means that users can all see the index function
  def index?
    true
  end
  # Covers new and create methods and means a new item can be created
  # if the user logged in is an admin user
  def create?
    @user.is_admin?
  end
  # Covers edit and update methods and means a new item can be created
  # if the user logged in is an admin user
  def update?
    @user.is_admin?
  end
  # Means an item can be destroyed if the logged in user is an admin
  def destroy?
    @user.is_admin?
  end
end
