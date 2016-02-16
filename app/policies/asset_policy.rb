class AssetPolicy < ApplicationPolicy
  # Means that users can all see the index function
  def index?
    true
  end
  # Means user can see json
  def json?
    true
  end
  # Covers new and means that all logged in user can see the
  # create new media form
  def new?
    true
  end
  # Covers create and means that a new asset can only be created if
  # the listing id chosen in the dropdown belongs to the user
  def create?
    Listing.belongs_to_current_user(@user).exists?(@record.listing_id)
  end
  # Covers update and shares the attributes of create method in that
  # the listing chosen in the dropdown must belong to the current user
  def update?
    create?
  end
  # Covers destroy and allows destruction if the asset chosen (via the
  # listing its attached to) belongs to the current user
  # current user
  def destroy?
    Asset.belongs_to_current_user(@user).exists?(@record.id)
  end
end
