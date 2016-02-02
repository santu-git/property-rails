/*
#Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
$(document).ready(function(){

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
      var $selected = $('#listing_agent_id').val();
      $('#listing_branch_id').find('option').remove();
      $.ajax({
        type: 'GET',
        url: '/admin/branches/json?id=' + $selected,
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
    }else{
      $('#listing_branch_id').find('option').remove();
    }
  }

  $('#listing_department_id').on('change',function(){
    toggleDepartmentElements();
  });

  $('#listing_agent_id').on('change',function(){
    loadBranchesForAgent();
  });

  $('#listing_lookup_postcode').on('click',function(e){
    if ($('#listing_postcode').val().length >= 3){
      var url = '/admin/geo/lookup?postcode=' + $('#listing_postcode').val();
      $.getJSON(url)
        .done(function(data){
          $('#listing_longitude').val(data[1]);
          $('#listing_latitude').val(data[0]);
        })
        .fail(function(jqXHR, textStatus, error){
          window.alert('Unable to find location');
          console.log(textStatus);
        });
    }else{
      window.alert('Please enter a postcode');
    }
    e.preventDefault();
  });

  toggleDepartmentElements();
  loadBranchesForAgent();

});
