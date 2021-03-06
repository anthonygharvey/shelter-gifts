class Item < ApplicationRecord
	belongs_to :list
	validates :name, :price, :photo, :quantity, :has_amount, :url, :button_text, :button_url, presence: true
	validates_inclusion_of :prime_status, in: [true, false]
	validates_format_of :url, with: /\A(http|https):\/\/amazon.com\/|([0-9])[A-Za-z0-9]+\z/

	def to_cents
		(self.price * 100).to_i
	end

	def quantity_remaining
		(self.quantity - self.has_amount)
	end

	def percent_gifted
		self.has_amount.to_f / self.quantity.to_f
	end

	def shelter
		self.list&.shelter
	end

end
