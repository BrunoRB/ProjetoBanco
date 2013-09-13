

$(document).ready(function() {
	/*
	 * Datepicker settings and initialization
	 */
	$.datepicker.setDefaults({
		dateFormat: "dd/mm/yy"
	});
	$('input[data-type="date"]').datepicker();
	
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
	    source: [
'uMembro1',
'KMembro2',
'HMembro3',
'wGerente',
'GMembro1',
'BMembro2',
'CMembro3',
'0Gerente',
'iMembro1',

	             ]
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
	
	$(function() {
		var members = [
		    'uMembro1',
		    'KMembro2',
		    'HMembro3',
		    'wGerente',
		    'GMembro1',
		    'BMembro2',
		    'CMembro3',
		    '0Gerente',
		    'iMembro1',
		];
	
		$('input[data-type="text-autocomplete-membros"]').autocomplete({
	      source: members
	    });
	});
	
});