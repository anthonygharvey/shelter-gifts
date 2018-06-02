class Item < ApplicationRecord
	belongs_to :list
	validates :name, :price, presence: true

end
