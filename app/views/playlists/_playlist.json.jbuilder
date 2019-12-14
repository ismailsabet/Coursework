json.extract! playlist, :id, :name, :num_of_songs, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)
