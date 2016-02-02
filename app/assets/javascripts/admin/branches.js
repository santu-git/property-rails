var ready;
ready = function() {
  $('#branch_lookup_postcode').on('click',function(e){
    if ($('#branch_postcode').val().length >= 3){
      var url = '/admin/geo/lookup?postcode=' + $('#branch_postcode').val();
      $.getJSON(url)
        .done(function(data){
          $('#branch_longitude').val(data[1]);
          $('#branch_latitude').val(data[0]);
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
};

$(document).ready(ready);
$(document).on('page:load', ready);
