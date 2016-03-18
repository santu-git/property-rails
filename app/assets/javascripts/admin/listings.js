/*
#Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
var ready;
ready = function() {

  function toggleDepartmentElements(){
    switch($('#listing_department_id').val()){
      case '1':
        $('.to-let').hide();
        $('.for-sale').show();
        break;
      case '2':
        $('.to-let').show();
        $('.for-sale').hide();
        break;
    }
  }

  function loadBranchesForAgent(){
    if ($('#listing_agent_id').val()){
      $('#listing_branch_id').find('option').remove();
      $.ajax({
        type: 'GET',
        url: '/admin/branches/json?id=' + $('#listing_agent_id').val(),
        dataType: 'json',
        success: function(data){
          if (data.length > 0){
            $.each(data, function(i, obj){
              $('#listing_branch_id').append($('<option>').text(obj.name).attr('value',obj.id));
            });
          }else{
            $('#listing_branch_id').append($('<option>').text('No Branches Found'));
          }
        }
      });      
    }
  }

  $('#listing_department_id').on('change',function(){
    toggleDepartmentElements();
  });

  $('#listing_agent_id').on('change',function(){
    loadBranchesForAgent();
  });

  $(document).on('change', '.btn-file :file', function() {
    var input = $(this), 
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  });

  $(document).ready( function() {
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
      var input = $(this).parents('.input-group').find(':text'),
      log = numFiles > 1 ? numFiles + ' files selected' : label;  
      if( input.length ) {
        input.val(log);
      } else {
        if( log ) alert(log);
      }  
    });
  });

  toggleDepartmentElements();
  loadBranchesForAgent();
};
$(document).ready(ready);
$(document).on('page:load', ready);
