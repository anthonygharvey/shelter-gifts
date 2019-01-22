require: 'item.js'
require: 'items.js'

function List(attributes) {
	this.id = attributes.id
	this.name = attributes.name
	this.shelter = attributes.shelter
	this.description = attributes.description
	this.url = attributes.url
	this.items = attributes.items
}

$(function () {
	List.templateSource = $("#list-template").html()
	List.template = Handlebars.compile(List.templateSource)
})

List.prototype.renderList = function () {
	return List.template(this)
}

$(document).on('turbolinks:load', function () {
	$(".wishlist").on("click", function (e) {
		var url = this.href
		$.get(url).success(function (data) {
			var list = new List(data)
			var newList = list.renderList()
			var item = new Item(data)
			var newItem = item.renderItem()
			var $mainContainer = $('.main_container')
			$mainContainer.html('')
			$mainContainer.append(newList)
			$mainContainer.append(newItem)
		})
		e.preventDefault()
	})

	$("#new_list").on("submit", function (e) {
		var $form = $(this);
		var url = $form.action
		var data = $form.serialize()
		$.post(url, data).success(function (data) {
			build_list(data)
		})
		e.preventDefault()
	})
})

function build_list(data) {
	var $mainContainer = $('.main_container')
	$mainContainer.html('')
	$mainContainer.append(build_header(data))
	$mainContainer.append(build_table(data))
	$mainContainer.append(delete_button(data))
	$mainContainer.append(build_item_cards(data))
}

function build_header(data) {
	var shelter = data[0] ? data[0].shelter : data.shelter
	var header = ''
	header += `<h1>${shelter.name}</h1>`
	header += `<p>Description: ${shelter.description}<br>`
	header += `Wishlist link:  <a href=${shelter.url} target='_blank'>${shelter.url}<br>`
	header += `<a href=/shelters/${shelter.id}>${shelter.name}</a>`
	return header
}

function build_table(data) {
	var items = data[0] ? data : data.items
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
	items.forEach(item => {
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
	var list = data[0] ? data[0].list : data
	button = '<br>'
	button += `<a href='/lists/${list.id}' data-method='delete' class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect", id="delete-button" rel="nofollow" data-upgraded=",MaterialButton,MaterialRipple" tabindex="0">Delete List<span class="mdl-button__ripple-container"><span class="mdl-ripple is-animating" style="width: 239.311px; height: 239.311px; transform: translate(-50%, -50%) translate(87px, 20px);"></span></span></a>`
	return button
}

function percent_gifted(item) {
	return Math.floor((item.has_amount * 100) / item.quantity)
}

String.prototype.capitalize = function () {
	return this.charAt(0).toUpperCase() + this.slice(1);
}