// require: 'lists.js';
$(document).on('turbolinks:load', function () {
	$("form input#search").on("click", function (e) {
		debugger
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
