$(document).ready(function() {
    $('input.ac_method').click(function(){
       if ($('input#ac_method_none').is(':checked')) {
         $('#contact_field').show();
         $('#leave').hide();
       } else {
         $('#contact_field').hide();
       };
    });
    $('#contact_field').hide();
});
