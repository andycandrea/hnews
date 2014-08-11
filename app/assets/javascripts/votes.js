$( document ).ready(function() {
  $('.votes').each(function() {
    var $upLink     = $(this).children('.upvote-link'),
        $downLink   = $(this).children('.downvote-link'),
        $upArrow    = $upLink.children('.up'),
        $downArrow  = $downLink.children('.down');

    $upLink.click(function(e) {

      $upArrow.toggleClass('clicked');

      if ($downArrow.hasClass('clicked')) {
        $downArrow.toggleClass('clicked');
      }
    });

    $downLink.click(function(e) {
      $downArrow.toggleClass('clicked');

      if ($upArrow.hasClass('clicked')) {
        $upArrow.toggleClass('clicked');
      }
    });
  });
});
