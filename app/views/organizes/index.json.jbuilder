json.array!(@organizes) do |organize|
  json.extract! organize, :id
  json.url organize_url(organize, format: :json)
end
