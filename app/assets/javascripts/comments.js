$('.comment').each(function() {
  var $this     = $(this),
      $replyDiv = $this.children(".reply-div:first"),
      $formDiv  = $this.children(".reply-form:first"),
      $buttons  = $this.find(".reply-button:first, .cancel-button:first");

  if ($this.parent().hasClass('odd-comment')) {
    $this.addClass('even-comment');
  } else {
    $this.addClass('odd-comment');
  }

  $buttons.click(function(e) {
    e.preventDefault();

    $formDiv.toggle();
    $replyDiv.toggle();
  });
});
