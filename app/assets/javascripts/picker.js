(function() {
  var ready;

  ready = function() {
    $('[data-toggle="popover"]').popover({
      placement: 'top',
      trigger: 'manual'
    });
    return $('[data-toggle="popover"]').click(function() {
      var clicked;
      clicked = this;
      return $('[data-toggle="popover"]').each(function(index, value) {
        if (value !== clicked) {
          return $(value).popover('hide');
        } else {
          return $(clicked).popover('toggle');
        }
      });
    });
  };

  window.pick_seat = function(seat_id) {
    return $.post('/picker/' + seat_id + '/pick', {}, function(data) {
      return window.reload_picker();
    });
  };

  window.give_up_seat = function() {
    return $.post('/picker/give_up', {}, function(data) {
      return window.reload_picker();
    });
  };

  window.request_seat = function(seat_id) {
    return $.post('/picker/' + seat_id + '/make_request', {}, function(data) {
      return window.reload_picker();
    });
  };

  window.cancel_request = function(seat_id) {
    return $.post('/picker/' + seat_id + '/cancel_request', {}, function(data) {
      return window.reload_picker();
    });
  };

  window.donate_seat = function(request_id) {
    return $.post('/picker/donate_seat', {
      seat_request_id: request_id
    }, function(data) {
      return window.reload_picker();
    });
  };

  window.reload_picker = function() {
    $('#seatpicker-management').parent().load('/picker #seatpicker-management');
    $('#seatpicker-room').load('/picker #seatpicker-room', function() {
      $(document).ready(ready);
    });
  };

  $(document).ready(ready);

  $(document).on('page:load', ready);

}).call(this);
