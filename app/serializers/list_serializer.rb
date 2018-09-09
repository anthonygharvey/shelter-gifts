class ListSerializer < ActiveModel::Serializer
  attributes :id, :shelter_id, :item_id, :name, :description, :url
  belongs_to :shelter
end
