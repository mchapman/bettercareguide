$(document).ready(function(){
  starRating.create('.rbstars','.jstarget');
});

// The widget
var starRating = {
  create: function(rbselector,jsselector) {
    $(rbselector).hide()
    var $jssel = $(jsselector)
    $(rbselector).each(function() {
      $(this)
        .find('input:radio')
        .each(function(i) {
          var rating = $(this).attr('value');
          var plural = rating=="1" ? "" : "s"
          var $item = $('<a href="#"></a>')
            .attr('title', rating+' star' + plural+' out of 5')
            .addClass('stars-'+rating)
            .text(rating);
          starRating.addHandlers($item);
          $jssel.append($item);

          if($(this).is(':checked')) {
            $item.prevAll().andSelf().addClass('show-value');
          }
        });
    });
    $jssel.addClass('jsstars');
  },
  addHandlers: function(item) {
    $(item).click(function(e) {
      // Handle Star click
      var $star = $(this);
      var $allLinks = $(this).parent();

      // Set the radio button value
      $allLinks
        .parent()
        .find('input:radio[value=' + $star.text() + ']')
        .attr('checked', true);

      // Set the ratings
      $allLinks.children().removeClass('show-value');
      $star.prevAll().andSelf().addClass('show-value');

      // prevent default link click
      e.preventDefault();

    }).hover(function() {
      // Handle star mouse over
      $(this).prevAll().andSelf().addClass('rating-over');
    }, function() {
      // Handle star mouse out
      $(this).siblings().andSelf().removeClass('rating-over')
    });
  }

}