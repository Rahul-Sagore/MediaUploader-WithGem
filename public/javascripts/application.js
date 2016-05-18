// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function init(){

	// VARIABLE DECLARATION
	var fileInput = document.getElementsByClassName('custom-file-input')[0];
	var fileLabel = document.getElementsByClassName('file-name')[0];

	// FUNCTION DEFINITION
	function updateFileName(event) {
    for ( i = 0; i < event.path.length; i++ ) {
        var tmpObj = event.path[i];
        
        if ( tmpObj.value !== undefined ) {
           	fileLabel.innerHTML = tmpObj.value.replace('C:\\fakepath\\', '');
        }
    }
	}

	// FUNCTION BINDING
	if(fileInput) {
		fileInput.onchange = updateFileName;
	}
}

window.onload = function() {
	init();
}