class Song < ApplicationRecord

  scope :inPlaylist, -> { where("playlist_id >= 1") }

  belongs_to :playlist, optional: true
  belongs_to :result, optional: true

  validates :name, presence: true
end
