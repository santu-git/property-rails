class AssetSerializer < ActiveModel::Serializer
  attributes :upload
  belongs_to :listing
  belongs_to :media_type
end
