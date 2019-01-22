function Item(attributes) {
	this.id = attributes.id
	this.name = attributes.name
	this.items = attributes.items
}

$(function () {
	Item.templateSource = $("#item-template").html()
	Item.template = Handlebars.compile(Item.templateSource)

})

Item.prototype.renderItem = function () {
	return Item.template(this)
}

$(document).on('turbolinks:load', function () {
	$("form input#search").on("click", function (e) {
		$.ajax({
			method: 'GET',
			url: this.parentElement.action,
			data: $(this.parentElement).serialize(),
			dataType: "script"
		}).success(function () {
			$('.page-content').html('')
		})
		e.preventDefault();
	});
})
