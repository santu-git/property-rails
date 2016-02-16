class AssetSerializer < ActiveModel::Serializer
  attributes :upload, :media_type_id
  belongs_to :listing
end
