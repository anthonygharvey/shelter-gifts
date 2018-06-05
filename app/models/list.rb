class List < ApplicationRecord
	belongs_to :shelter
	has_many :items
	validates :name, :url, presence: true
	validates_format_of :url, with: /\A(http|https):\/\/www.amazon.com\/gp\/registry\/wishlist\/|([0-9])[A-Za-z0-9]+\z/

	def items_by_priority(priority)
		self.items.select do |item|
			item.priority.upcase === priority.upcase
		end
	end

	def items_by_prime_status(status)
		self.items.select do |item|
			item.prime_status == status
		end
	end

	def items_by_price_range(lower, upper)
		self.items.select do |item|
			(lower.to_f * 100) <= item.to_cents && item.to_cents <= (upper.to_f * 100)
		end
	end
end
