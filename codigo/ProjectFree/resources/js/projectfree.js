

$(document).ready(function() {
	$.datepicker.setDefaults({
		dateFormat: "dd/mm/yy"
	});
	
	$('input[data-type="timestamp"]').datepicker();
});