class AssetPolicy < ApplicationPolicy
  def index?
    true
  end
  def create?
    true
  end
  def update?
    Listing.belongs_to_current_user(@user).exists?(@record.listing_id)
  end
  def destroy?
    update?
  end
end
