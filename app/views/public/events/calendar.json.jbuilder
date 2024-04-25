json.array!(@posts) do |event|
  json.id event.id
  json.title event.title
  json.start event.date
  json.end event.date
end