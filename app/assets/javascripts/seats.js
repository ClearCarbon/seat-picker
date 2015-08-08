var init_seat_picker = function() {
  $('[data-toggle="popover"]').popover( 'destroy' );
  $('[data-toggle="popover"]').off();

  $('[data-toggle="popover"]').popover({
    placement: 'top',
    trigger: 'manual'
  });

  $('[data-toggle="popover"]').click(function() {
    var clicked = this;
    $('[data-toggle="popover"]').each(function(index, value) {
      if (value !== clicked) {
        $(value).popover('hide');
      } else {
        $(clicked).popover('toggle');
      }
    });
    
    $('.popover .ajax-modal').click(function() {
      $('.popover').popover('hide');
    });

    return false;
  });
};

$(document).ready(init_seat_picker);
$(document).ready(function() {
  $('.ajax-modal').on('click', function (e) {
    $('.popover').popover('hide');
  })
});

