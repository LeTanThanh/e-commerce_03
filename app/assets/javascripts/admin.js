$(document).ready(function(){
  $(document).on('click','.btn-request-control', function () {
    btnRequestControlClick($(this));
  });
});

function btnRequestControlClick(btn) {
  var page = btn.data('page');
  var requestCounter = btn.data('request-counter');
  var requestIndex = btn.data('request-index');
  var requestId = btn.data('request-id');
  var requestStatus = btn.data('request-status');
  var url = 'requests/' + requestId;
  $.ajax({
    type: 'POST',
    url: url,
    data: {
      page: page,
      request_counter: requestCounter,
      request_status: requestStatus
    },
    dataType: 'json',
    success: function(response){
      $('.request-container-' + requestIndex).replaceWith(response.html);
    }
  });
}
