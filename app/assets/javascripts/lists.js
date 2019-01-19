require: 'item.js'

$(document).on('turbolinks:load', function () {
	$(".wishlist").on("click", function (e) {
		$.ajax({
			method: 'GET',
			url: this.href + '/items'
		}).success(function (data) {
			var $mainContainer = $('.main_container')
			$mainContainer.html('')
			$mainContainer.append(build_header(data))
			$mainContainer.append(build_table(data))
			$mainContainer.append(delete_button(data))
			$mainContainer.append(build_item_cards(data))
		})
		e.preventDefault()
	})
})

function build_header(data) {
	var header = ''
	header += `<h1>${data[0].shelter.name}</h1>`
	header += `<p>Description: ${data[0].shelter.description}<br>`
	header += `Wishlist link:  <a href=${data[0].shelter.url} target='_blank'>${data[0].shelter.url}<br>`
	header += `<a href=/shelters/${data[0].shelter.id}>${data[0].shelter.name}</a>`
	return header
}

function build_table(data) {
	var table = ''
	table += `<table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">`
	table += `<thead><tr>`
	table += `<th class="mdl-data-table__cell--non-numeric">Item</th>`
	table += `<th>Priority</th>`
	table += `<th>Requested</th>`
	table += `<th>Donated</th>`
	table += `<th>Received</th>`
	table += `</tr></thead>`

	table += `<tbody>`
	data.forEach(item => {
		table += build_table_row(item)
	});
	table += `</table>`
	return table
}

function build_table_row(item) {
	var row = ''
	row += `<tr>`
	row += `<td class="mdl-data-table__cell--non-numeric">${item.name}</td>`
	row += `<td>${item.priority.capitalize()}</td>`
	row += `<td>${item.quantity}</td>`
	row += `<td>${item.has_amount}</td>`
	row += `<td>${percent_gifted(item)}%</td>`
	row += `</tr></tbody>`
	return row
}

function delete_button(data) {
	button = '<br>'
	button += `<a href='/lists/${data[0].list.id}' data-method='delete' class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect", id="delete-button" rel="nofollow" data-upgraded=",MaterialButton,MaterialRipple" tabindex="0">Delete List<span class="mdl-button__ripple-container"><span class="mdl-ripple is-animating" style="width: 239.311px; height: 239.311px; transform: translate(-50%, -50%) translate(87px, 20px);"></span></span></a>`
	return button
}

function percent_gifted(item) {
	return Math.floor((item.has_amount * 100) / item.quantity)
}

String.prototype.capitalize = function () {
	return this.charAt(0).toUpperCase() + this.slice(1);
}