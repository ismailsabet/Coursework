json.extract! song, :id, :name, :author, :album, :playlist_id, :created_at, :updated_at
json.url song_url(song, format: :json)
