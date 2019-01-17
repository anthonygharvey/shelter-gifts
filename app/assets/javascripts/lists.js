$(document).on('turbolinks:load', function () {
	$(".wishlist").on("click", function (e) {
		$.ajax({
			method: 'GET',
			url: this.href
		}).success(function (data) {
			var $mainContainer = $('.main_container')
			$mainContainer.html('')
			$mainContainer.append(build_header(data))
			$mainContainer.append(build_table(data))
			// $mainContainer.append(delete_button(data))
		})
		e.preventDefault()
	})
})

function build_header(data) {
	var header = ''
	header += `<h1>${data.name}</h1>`
	header += `<p>Description: ${data.description}<br>`
	header += `Wishlist link:  <a href=${data.url} target='_blank'>${data.url}<br>`
	header += `<a href=${data.shelter.url}>${data.shelter.name}</a>`
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
	data.items.forEach(item => {
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

// TODO: build delete button and add item cards
function delete_button(data) {
	button = '<br>'
	button += `<a href='/lists/${data.id}' data-method='delete' class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect", id="delete-button">Delete List</a>`
	button += `<div class="mdl-tooltip mdl-tooltip--large" for= "delete-button">`
	button += `List will be permanently deleted </div`
	return button
}

function percent_gifted(item) {
	return Math.floor((item.has_amount * 100) / item.quantity)
}

String.prototype.capitalize = function () {
	return this.charAt(0).toUpperCase() + this.slice(1);
}