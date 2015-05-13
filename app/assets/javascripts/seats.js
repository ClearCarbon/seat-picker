var init_seat_picker = function() {
  $('[data-toggle="popover"]').popover( 'destroy' );
  $('[data-toggle="popover"]').off();

  $('[data-toggle="popover"]').popover({
    placement: 'top',
    trigger: 'manual'
  });

  $('[data-toggle="popover"]').click(function() {
    var clicked;
    clicked = this;
    $('[data-toggle="popover"]').each(function(index, value) {
      if (value !== clicked) {
        $(value).popover('hide');
      } else {
        $(clicked).popover('toggle');
      }
    });

    return false;
  });
};

// pick_seat = function(seat_id) {
//   $.post('/picker/' + seat_id + '/pick', {}, function(data) {
//     reload_picker();
//   });
// };
//
// give_up_seat = function() {
//   $.post('/picker/give_up', {}, function(data) {
//     reload_picker();
//   });
// };
//
// request_seat = function(seat_id) {
//   $.post('/picker/' + seat_id + '/make_request', {}, function(data) {
//     reload_picker();
//   });
// };
//
// cancel_request = function(seat_id) {
//   $.post('/picker/' + seat_id + '/cancel_request', {}, function(data) {
//     reload_picker();
//   });
// };
//
// donate_seat = function(request_id) {
//   $.post('/picker/donate_seat', {
//     seat_request_id: request_id
//   }, function(data) {
//     reload_picker();
//   });
// };
//
// reload_picker = function() {
//   var scrollY = $(window).scrollTop();
//   $('#seatpicker-management').parent().load('/picker #seatpicker-management');
//   $('#seatpicker-room').load('/picker #seatpicker-room', ready.call(scrollY));
// };

$(document).ready(init_seat_picker);
