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

	def get_items
		# page = Nokogiri::HTML(open(self.url)).css("[id^=data-id]")
		page = Nokogiri::HTML(open(self.url)).css("li[data-id]")
		# binding.pry
		page.each do |item|
			i = self.items.new
			
			i.name = item.css("a[id^=itemName]").text # Item name
			i.url = "https://amazon.com" + item.css("a[id^=itemName]").attribute("href").value # item url
			i.price =item.css("span[id^=itemPrice] span.a-offscreen").text.gsub("$","") # price
			#TODO: If price == nil && "See all buying options" avalilable, then click and scrape the page for: Price + Shipping, Condition & Add to cart link
			i.prime_status =item.css("div[data-item-prime-info] i.a-icon-prime") #prime item. Will return the object if prime; empty array i-f not
			i.comment =item.css("span[id^=itemComment]").text #item comment
			i.priority =item.css("span[id^=itemPriorityLabel]").text # item priority
			i.quantity =item.css("span[id^=itemRequested_]").text # item quantity requested
			i.has_amount =item.css("span[id^=itemPurchased_]").text # item quantity purchased
			i.photo =item.css("img").attribute("src").value # image
			# item"https://amazon.com" + .css("span.a-button-inner a").attribute("href").value
			# binding.pry
			i.save
		end
	end

end
