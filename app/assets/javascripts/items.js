$(function () {
	$("form input#search").on("click", function (e) {
		$.ajax({
			method: 'GET',
			url: this.parentElement.action,
			data: {
				city: $('#city')[0].value,
				state: $('#state')[0].value,
				shelter_type: $('#type')[0].value,
				priority: $('#priority')[0].value
			},
			dataType: "script"
		})
		e.preventDefault();
	});
})

