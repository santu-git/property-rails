class ListingPolicy < ApplicationPolicy
  # Means that users can all see the index function
  def index?
    true
  end
  # Means that all authenticated users can see the add listing form
  def new?
    true
  end
  # Covers create and means that a listing can be created if the branch
  # chosen in the dropdowns belongs to the current user
  def create?
    Branch.belongs_to_current_user(@user).exists?(@record.branch_id)
  end
  # Covers update and means that if the branch chosen in dropdowns as
  # well as the listing itself belong to the current user then allow the update
  # otherwise don't
  def update?
    branch = Branch.belongs_to_current_user(@user).exists?(@record.branch_id)
    listing = Listing.belongs_to_current_user(@user).exists?(@record.id)
    branch && listing ? true : false
  end
  # Covers destroy and means that a listing can be destroyed if the Listing
  # belongs to the current user
  def destroy?
    Listing.belongs_to_current_user(@user).exists?(@record.id)
  end
end
