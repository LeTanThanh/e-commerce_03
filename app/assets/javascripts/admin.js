$(document).ready(function(){
  addActiveClassToMenu();

  $(document).on('click','.btn-request-control', function () {
    btnRequestControlClick($(this));
  });

  $('.btn-search-user').on('click', function() {
    var input = $('.search-user-input').val();
    $.ajax({
      type: 'GET',
      url: '/admin/users',
      data: {
        input: input
      },
      dataType: 'json',
      success: function(response) {
        $('.user-table').html(response.html_user_table);
        $('.user-paginate').html(response.html_user_paginate);
      }
    });
  });
  
  $(document).on('click', '.btn-delete-user', function() {
    var btnDeleteUser = $(this);
    var userId = btnDeleteUser.data('user-id');
    var page = btnDeleteUser.data('page');
    var perPage = btnDeleteUser.data('per-page');
    var input = btnDeleteUser.data('input');
    $.ajax({
      type: 'DELETE',
      url: '/admin/users',
      data: {
        user_id: userId,
        page: page,
        input: input
      },
      dataType: 'json',
      success: function(response) {
        $('#flash').html(response.html_flash);
        if (response.delete_user_success) {
          $('.user-row-' + userId).remove();
          $('.user-table > tbody:last-child').append(response.html_user);
          $('.user-no').each(function(index) {
            $(this).html((page - 1) * perPage + index + 1);
          })
        }
      }
    });
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

function addActiveClassToMenu() {
  var menuIndex = -1;
  var path = window.location.pathname;

  if (path == '/admin/requests') {
    menuIndex = 0;
  } else if (path == '/admin/users') {
    menuIndex = 1;
  }

  if (menuIndex != -1) {
    $($('.vertical-menu').children().get(menuIndex)).addClass('active');
  }
}
