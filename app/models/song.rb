class Song < ApplicationRecord

  # Selects only songs that belong to a playlist rather than a search result
  scope :inPlaylist, -> { where("playlist_id >= 1") }

  # Both are optional because any song added will always have one of the two as nill
  # A song either has a playlist_id or a result_id, never both at the same time
  belongs_to :playlist, optional: true
  belongs_to :result, optional: true

  validates :name, :artist, :album, presence: true
end
