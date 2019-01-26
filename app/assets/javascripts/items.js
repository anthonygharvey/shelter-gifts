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
