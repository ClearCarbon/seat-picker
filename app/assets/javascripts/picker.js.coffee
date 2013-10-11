ready = ->
    $('[data-toggle="popover"]').popover({placement: 'top', trigger: 'manual'})
    $('[data-toggle="popover"]').click -> 
        clicked = this
        $('[data-toggle="popover"]').each (index, value) ->
          if value != clicked
            $(value).popover('hide')
          else
            $(clicked).popover('toggle')

window.pick_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/pick', {},
     (data) ->
        window.reload_picker()

window.give_up_seat = -> 
    $.post '/picker/give_up', {},
     (data) ->
        window.reload_picker()

window.request_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/make_request', {},
     (data) ->
        window.reload_picker()

window.cancel_request = (seat_id) -> 
    $.post '/picker/' + seat_id + '/cancel_request', {},
     (data) ->
        window.reload_picker()

window.donate_seat = (request_id) -> 
    $.post '/picker/donate_seat', {seat_request_id: request_id},
     (data) ->
        window.reload_picker()

window.reload_picker = () ->
    $('#seatpicker-management').parent().load '/picker #seatpicker-management'
    $('#seatpicker-room').load '/picker #seatpicker-room', () ->
      ready

$(document).ready(ready)
$(document).on('page:load', ready)
