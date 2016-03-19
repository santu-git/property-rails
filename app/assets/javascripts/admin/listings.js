/*
#Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
var ready;
ready = function() {

  $(document).on('change', '.btn-file :file', function() {
    var input = $(this), 
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  });

  $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
    var input = $(this).parents('.input-group').find(':text'),
    log = numFiles > 1 ? numFiles + ' files selected' : label;  
    if( input.length ) {
      input.val(log);
    } else {
      if( log ) alert(log);
    }  
  });

};
$(document).ready(ready);
$(document).on('page:load', ready);
