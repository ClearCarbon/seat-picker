jQuery ->

  $('[data-toggle="tooltip"]').tooltip()

window.pick_seat = (seat_id) -> 
    $.post '/picker/' + seat_id + '/pick', {},
     (data) ->
        location.reload()
