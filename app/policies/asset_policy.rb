class AssetPolicy < ApplicationPolicy
  def index?
    true
  end
  def create?
    # If the listing chosen to attach the media to belongs to the current user
    # then create and update are possible for this asset
    Listing.belongs_to_current_user(@user).exists?(@record.listing_id)
  end
  def update?
    create?
  end
  def destroy?
    # If the asset belongs to the current user
    Asset.belongs_to_current_user(@user).exists?(@record.id)
  end
end
