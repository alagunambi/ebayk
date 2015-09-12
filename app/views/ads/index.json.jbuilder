json.array!(@ads) do |ad|
  json.extract! ad, :id, :contact, :ad_id, :link
  json.url ad_url(ad, format: :json)
end
