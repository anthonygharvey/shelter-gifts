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
			# binding.pry
			(lower.to_f * 100) <= item.to_cents && item.to_cents <= (upper.to_f * 100)
		end
	end

	def get_items(list_url)
		user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
		page = Nokogiri::HTML(open(list_url, 'User-Agent' => "Ruby/#{RUBY_VERSION}"))

		if page.css("div#endOfListMarker") != []
			end_of_list_marker = page.css("div#endOfListMarker")
		end

		if !page.css("a.wl-see-more").empty?
			more = "https://amazon.com"+ page.css("a.wl-see-more").attribute("href").value
		else
			more = false
			last_part = "https://amazon.com" + page.css("form.scroll-state input").attribute("value").value
		end

		items = page.css("li[data-id]")
		items.each do |item|
			i = self.items.new
			next if item.css("span[id^=itemName]").text == "This title is no longer available" ||
							item.css("a.a-link-normal").empty?

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
			i.url = "https://amazon.com" + item.css("a.a-link-normal").attribute("href").value
			i.button_text = item.css("span.a-button-inner").text
			i.button_url = "https://www.amazon.com" + item.css("span.a-button-inner a").attribute("href").value
			!i.valid? || i.price == nil ? next : i.save
		end

		if more
			get_items(more)
		else
			if page.css("a.wl-see-more").empty? # last page if true
				return
			end
			get_items(last_part)
		end
	end

end
