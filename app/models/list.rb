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
		page = Nokogiri::HTML(open(self.url)).css("li[data-id]")
		page.each do |item|
			i = self.items.new
			
			i.name = item.css("a[id^=itemName]").text
			if item.attribute("data-price").value == "-Infinity"
				i.price = nil
			else
				i.price = item.attribute("data-price").value
			end
			i.photo =item.css("img").attribute("src").value
			i.prime_status =item.css("div[data-item-prime-info] i.a-icon-prime")
			i.comment =item.css("span[id^=itemComment]").text
			i.quantity =item.css("span[id^=itemRequested_]").text
			i.priority =item.css("span[id^=itemPriorityLabel]").text
			i.has_amount =item.css("span[id^=itemPurchased_]").text
			i.url = "https://amazon.com" + item.css("a[id^=itemName]").attribute("href").value
			i.save
		end
	end

	#Refactor Scrapping
	# the #get_items method works for a wishlist page with all items currently in view.  If a list has enough items that a "see more" link is generated, it will not scrape those items.  Thought about using the Watir-Scroll gem to scroll unitl the div#endofListMaker element is in view; but all of the data I need is present on the first page (1st page items and the see more link).
	#TODO: 1) add #get_page(url) method.  It 1) scrapes the url provided. 2) checks for the "see more" (link page.css("a.wl-see-more").attribute("href").value), if present, call the #get_page(url) method, else call #get_items(page)

	#TODO: 2) refactor #get_items.  1) Add parameter (page) for the page to iterate through.  2) This method will be called by the #get_page(url) method, which will pass it a Nokogiri page object.

	#

end
