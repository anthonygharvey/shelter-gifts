class ShelterSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :state, :shelter_type, :description, :website_url
  has_many :lists
end
