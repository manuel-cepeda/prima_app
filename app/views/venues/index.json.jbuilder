json.array!(@venues) do |venue|
  json.extract! venue, :title, :body
  json.url venue_url(venue, format: :json)
end