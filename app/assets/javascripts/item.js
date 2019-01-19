function build_item_cards(data) {
	var shelter = data[0] ? data[0].shelter : data.shelter
	var items = data[0] ? data : data.items
	cards = `<br>`
	cards += `<ul class="flex-container">`
	items.forEach(item => {
		var shelter_url = `
			<a ${shelter.website_url ? `href="${shelter.website_url}" target='_blank'` : ''}>${shelter.name}</a>
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
				<li class="flex-item">${shelter.city}, ${shelter.state}</li>
			</ul >
		</div >

		<a href='${item.button_url}' target='_blank' class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect">${item.button_text}</a>
	</div >
</li > `
	});
	return cards
}