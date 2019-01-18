class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :photo, :prime_status, :comment, :quantity, :has_amount, :priority, :url, :button_text, :button_url
	belongs_to :list
end
