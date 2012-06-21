function doGeocoding(geocoder, address) {
    // clear all the values in case the form is submitted before we get back
    $('input#lat').val('');
    $('input#lng').val('');
    var inputGeog = $('input#geog')
    $.data(document.body,'stash',"");
    if (address.length > 0 && address !== inputGeog.attr('data-default')) {
        geocoder.geocode( { 'address': address+',UK'}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                $('input#lat').val(results[0].geometry.location.lat());
                $('input#lng').val(results[0].geometry.location.lng());
                $.data(document.body,'stash',address);
            } else {
                console.log('Failed to Geocode ' + address + '  ' + status);
            }
        });
    }
};

$(document).ready(function() {

  $('input.clear').each(function() {

    var def_val;
    
    def_val = $(this).attr('data-default');

    // if the field is blank put in the helper text
    if($(this).val() == '') {
        $(this)
            .addClass('inactive_input')
            .val(def_val)
      }

    $(this)
      // stash the helper text
      .data('default',def_val)

      .focus(function() {
        $(this).removeClass('inactive_input');
        if($(this).val() == $(this).data('default') || '') {
          $(this).val('');
        }
      })

      .blur(function() {
        var default_val = $(this).data('default');
        if($(this).val() == '') {
          $(this).addClass('inactive_input');
          $(this).val($(this).data('default'));
        }
      });
  });

  $('input#submit').click(function() {
    var errs = [];
    var noProvider = $('input#provider').val() === $('input#provider').attr('data-default');
    var geogInput = $('input#geog');
    var address = geogInput.val();
    var hasGeog = (address !== geogInput.attr('data-default'));
    if (hasGeog)  {
        var radius = $('input#radius').val();
        if ($.isNumeric(radius) !== true || radius < 5 || radius > 50) {
            errs.push("You must enter a value between 5 and 50 for maximum distance to " + address);
        }
    }
    if ($('input:checked').length === 0) { errs.push("You must select at least one of 'at home' and 'in a residential home'."); }
    if (noProvider && !hasGeog)  { errs.push("You must specify either part of the provider name or the location."); }
    if (errs.length > 0) {
        $('#srcherr').remove();
        $('.span8').prepend('<div class="row" id="srcherr"><div class="span6 offset1"><div class="alert alert-error">'+errs.join('<br />')+'<a class="close" data-dismiss="alert" href="#">&times;</a></div></div></div>');
        return false;
    }
    var stashedAddress = $.data(document.body,'stash');
      if (address !== stashedAddress) {
        $('input#lat').val('');
        $('input#lng').val('');
    }
  });

  (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1&appId=385595358119901";
            fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
  (function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs"));
  window.setTimeout(function() {
      $('#sm-btn').hide().css('z-index','2').show(300);
      },
      4000);
});

function initialize() {
    var geocoder = new google.maps.Geocoder();

    // Set up function to do the geocoding when the town is changed
    $('input#geog').blur(function() {
        var geogInput = $('input#geog');
        var address = geogInput.val();
        var stashedAddress = $.data(document.body,'stash');
        if (address !== stashedAddress) {
            doGeocoding(geocoder, address);
        }
    });

    // Do the geocoding with what is passed unless we have a geog, lat and lng
    var geogInput = $('input#geog')
    var address = geogInput.val();
    if ((address.length > 0 && $('input#lat').val().length > 0 && $('input#lng').val().length > 0) || (address === geogInput.attr('data-default'))) {
        // then we assume everything is OK and save making the API call.  Stash the data for comparison.
        $.data(document.body, 'stash', address);
    } else {
        doGeocoding(geocoder, address);
    }
};

function loadScript() {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize';
//    script.src = 'http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize';
    document.body.appendChild(script);
}

window.onload = loadScript;