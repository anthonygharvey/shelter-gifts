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
		var url = $form[0].action
		var data = $form.serialize()
		$.post(url, data).success(function (data) {
			var $mainContainer = $('.main_container')
			$mainContainer.html('')
			build_list(data)
			build_items(data)
		})
		e.preventDefault()
	})
})

function build_list(data) {
	var list = new List(data)
	var newList = list.renderList()
	var $mainContainer = $('.main_container')
	$mainContainer.append(newList)
}

function build_items(data) {
	var item = new Item(data)
	var newItem = item.renderItem()
	var $mainContainer = $('.main_container')
	$mainContainer.append(newItem)
}
