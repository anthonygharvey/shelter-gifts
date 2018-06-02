class List < ApplicationRecord
	belongs_to :shelter
	validates :name, :url, presence: true
	validates_format_of :url, with: /\A(http|https):\/\/www.amazon.com\/gp\/registry\/wishlist\/|([0-9])[A-Za-z0-9]+\z/
end
