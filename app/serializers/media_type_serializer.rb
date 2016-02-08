class MediaTypeSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_many :assets
end
