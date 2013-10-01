json.array!(@seats) do |seat|
  json.extract! seat, :row, :number
  json.url seat_url(seat, format: :json)
end
