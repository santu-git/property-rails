class AssetSerializer < ActiveModel::Serializer
  attributes :id, :upload
  belongs_to :listing
  belongs_to :media_type
end
