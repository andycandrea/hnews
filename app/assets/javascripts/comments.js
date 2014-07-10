$('.comment').each(function() {
  if ($(this).parent().hasClass('comment') && $(this).parent().hasClass('odd-comment')) {
    $(this).addClass('even-comment');
  } else {
    $(this).addClass('odd-comment');
  }
  
  var buttons = $(this).find('.btn').slice(0,3);
  buttons.splice(1,1);
  
  var replyDiv = $(this).find('.reply-div').first();
  var formDiv = $(this).find('.reply-form').first();
  
  buttons.click(function() {
    formDiv.toggle();
    replyDiv.toggle();
  });
});
