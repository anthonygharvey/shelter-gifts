class Item < ApplicationRecord
	belongs_to :list
	validates :name, :price, :photo, :quantity, :has_amount, presence: true
	validates_inclusion_of :prime_status, in: [true, false]

end
