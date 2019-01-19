require: 'item.js'

$(document).on('turbolinks:load', function () {
	$("#search").on("click", function (e) {
		e.preventDefault()
		$('.page-content').slideUp("fast", function () { })
		$.ajax({
			method: 'GET',
			url: this.parentElement.action,
			data: $(this.parentElement).serialize(),
		}).success(function (data) {
			// debugger
			var $itemContainer = $('ul#items')
			$itemContainer.html('')
			$itemContainer.append(build_item_cards(data))
		})
	})
})