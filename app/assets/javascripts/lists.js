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
			$mainContainer.append(delete_button(data))
			$mainContainer.append(build_item_cards(data))
		})
		e.preventDefault()
	})
})

function build_header(data) {
	var header = ''
	header += `<h1>${data.name}</h1>`
	header += `<p>Description: ${data.description}<br>`
	header += `Wishlist link:  <a href=${data.url} target='_blank'>${data.url}<br>`
	header += `<a href=/shelters/${data.shelter.id}>${data.shelter.name}</a>`
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

function delete_button(data) {
	button = '<br>'
	button += `<a href='/lists/${data.id}' data-method='delete' class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect", id="delete-button" rel="nofollow" data-upgraded=",MaterialButton,MaterialRipple" tabindex="0">Delete List<span class="mdl-button__ripple-container"><span class="mdl-ripple is-animating" style="width: 239.311px; height: 239.311px; transform: translate(-50%, -50%) translate(87px, 20px);"></span></span></a>`
	return button
}

function percent_gifted(item) {
	return Math.floor((item.has_amount * 100) / item.quantity)
}

function build_item_cards(data) {
	cards = `<br>`
	cards += `<ul class="flex-container">`
	data.items.forEach(item => {
		var shelter_url = `
			<a ${data.shelter.website_url ? `href="${data.shelter.website_url}" target='_blank'` : ''}>${data.shelter.name}</a>
		`
		cards += `<li class="flex-item items">
	<div class="demo-card-square mdl-card mdl-shadow--2dp">
		<div class="mdl-card__title mdl-card--expand">
			<h2 class="mdl-card__title-text item-photo"><img src="${item.photo}" alt=""></h2>
		</div>
		<div class="mdl-card__supporting-text">
			${item.name.slice(0.75)}
			<h4>$${Number(item.price).toFixed(2)}</h4>
			<ul class="flex-container item-stats">
				<li class="flex-item">Priority: ${item.priority.capitalize()}</li>
				<li class="flex-item">Need: ${item.quantity}</li>
				<li class="flex-item">Has: ${item.has_amount}</li>
			</ul>
			<ul class="flex-container item-stats">
				<li class="flex-item">${shelter_url}</li>
				<li class="flex-item">${data.shelter.city}, ${data.shelter.state}</li>
			</ul >
		</div >

		<a href='${item.button_url}' target='_blank' class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect">${item.button_text}</a>
	</div >
</li > `
	});
	return cards
}

String.prototype.capitalize = function () {
	return this.charAt(0).toUpperCase() + this.slice(1);
}