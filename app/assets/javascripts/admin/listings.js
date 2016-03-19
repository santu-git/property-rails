$(document).on('change', '.btn-file :file', function() {
  var input = $(this), 
  numFiles = input.get(0).files ? input.get(0).files.length : 1,
  label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.parents('.input-group').find(':text').val(label);
});
