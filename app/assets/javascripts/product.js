$(document).ready(function(){
  var newCommentMessage = $('.new-comment-message');
  var btnSendComment = $('.btn-send-comment');
  var userRatingPoint = $('#user_rating_point');
  var btnSendRating = $('#btn-send-rating')

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
  
  btnSendRating.on('click', function () {
    var productId = btnSendRating.data('product-id');
    var point = userRatingPoint.val();
    var url = '/products/' + productId;

    $.ajax({
      type: 'PATCH',
      url: url,
      data: {
        point: point
      },
      dataType: 'json',
      success: function(response) {
        $('#flash').html(response.html_flash);
        var save_success = response.save_success;
        if(save_success) {
          $('#rating-point').html(response.html_rating_poin);
        }
      }
    });
  });
});
