class Item < ApplicationRecord
	belongs_to :list
	validates :name, :price, :photo, :quantity, :has_amount, :url, presence: true
	validates_inclusion_of :prime_status, in: [true, false]
	validates_format_of :url, with: /\A(http|https):\/\/www.amazon.com\/|([0-9])[A-Za-z0-9]+\z/
end
