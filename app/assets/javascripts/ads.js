
var ready;

ready = function(){

$('#start-button').on('click', function () {
  var $btn = $(this).button('loading')
  // business logic...
  $btn.button('reset')
})


 $(document).ready(function(){
    $('#export-details_from_date').datepicker({"autoclose": true});
    $('#export-details_to_date').datepicker({"autoclose": true});
  });

}

$(document).ready(ready);
$(document).on('page:load', ready);