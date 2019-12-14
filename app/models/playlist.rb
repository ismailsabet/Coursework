class Playlist < ApplicationRecord
  attr_accessor :num_of_songs
  has_many :songs, dependent: :destroy
  validates :name, uniqueness: true
  validates :name, presence: true
end
