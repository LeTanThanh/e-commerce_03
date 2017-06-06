$(document).ready(function(){
  var newCommentMessage = $('.new-comment-message');
  var btnSendComment = $('.btn-send-comment');
  
  btnSendComment.on('click', function () {
    var productId = btnSendComment.data('product-id');
    var message = newCommentMessage.val();
    var url = '/comments';

    $.ajax({
      type: 'POST',
      url: url,
      data: {
        product_id: productId,
        message: message,
      },
      dataType: 'json',
      success: function(response) {
        var save_success = response.save_success;
        if(save_success) {
          newCommentMessage.val('');
          $('.list-comment').prepend(response.html_comment);
        }
        else {
          $('#flash').html(response.html_flash);
        }
      }
    });
  });
});
