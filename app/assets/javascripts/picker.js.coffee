jQuery ->
    window.init_picker()

window.pick_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/pick', {},
     (data) ->
        window.reload_picker()

window.give_up_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/give_up', {},
     (data) ->
        window.reload_picker()

window.request_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/make_request', {},
     (data) ->
        window.reload_picker()

window.reload_picker = () ->
    $('#seatpicker-room').load '/picker #seatpicker-room', () ->
      window.init_picker()

window.init_picker = () ->
    $('[data-toggle="popover"]').popover({placement: 'top', trigger: 'manual'})
    $('[data-toggle="popover"]').click -> 
        $(this).popover('toggle')
