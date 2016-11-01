json.array!(@vendors) do |vendor|
  json.extract! vendor, :id
  json.url vendor_url(payee, format: :json)
end
