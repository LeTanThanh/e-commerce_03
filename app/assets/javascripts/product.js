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
        if(response.save_success) {
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
    var ratingPoint = userRatingPoint.val();
    var userRated = btnSendRating.data('user-rated');
    var ratingId = btnSendRating.data('rating-id');

    if (userRated) {
      $.ajax({
        type: 'PATCH',
        url: '/ratings/' + ratingId,
        data: {
          product_id: productId,
          rating_point: ratingPoint,
          rating_id: ratingId
        },
        dataType: 'json',
        success: function(response) {
          updateRatingView(response);
        }
      });
    }
    else {
      $.ajax({
        type: 'POST',
        url: '/ratings',
        data: {
          product_id: productId,
          rating_point: ratingPoint
        },
        dataType: 'json',
        success: function(response){
          updateRatingView(response);
        }
      });
    }
  });

  function updateRatingView(response) {
    $('#flash').html(response.html_flash);
    if(response.save_success) {
      $('#rating-point').html(response.html_rating_poin);
      btnSendRating.data('user-rated', true);
    }
  }
});
