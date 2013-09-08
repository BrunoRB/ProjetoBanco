

$(document).ready(function() {
	/*
	 * Datepicker settings and initialization
	 */
	$.datepicker.setDefaults({
		dateFormat: "dd/mm/yy"
	});
	$('input[data-type="timestamp"]').datepicker();
	
	
	/*
	 * Cleditor settings and initialization
	 */
	$.cleditor.defaultOptions.width = 600;
	$.cleditor.defaultOptions.height = 200;
	// Initialize cleditors
	$('textarea[data-type="text-multi"]').cleditor();
	
	
	/*
	 * Autocomplete settings and initialization
	 */
	$('input[data-type="text-autocomplete"]').autocomplete({
	    source: ['Bruno (bruno@hotmail.com)', 'Fabricio (fabricio@hotmail.com)', 
	             'Maikon (maikon@hotmail.com', 'Roberto (roberto@hotmail.com)', 'Ebara (ebara@migue.com)']
	});
	
	/*
	 * Spinner settings and initialization
	 */
	$('input[data-type="text-number"]').spinner({
		min: 0, max: 100
	});
	

	$('input').click(function() {
		$(this).css('background-color', 'white');
	});
	
});