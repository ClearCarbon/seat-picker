jQuery ->
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover({placement: 'top'})

window.pick_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/pick', {},
     (data) ->
        location.reload()

window.give_up_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/give_up', {},
     (data) ->
        location.reload()

window.request_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/make_request', {},
     (data) ->
        location.reload()
