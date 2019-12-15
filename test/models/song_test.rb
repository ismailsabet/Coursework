require 'test_helper'

class SongTest < ActiveSupport::TestCase

  setup do
    @playlist = playlists(:one)
  end

  test "should not save empty song" do
    song = Song.new

    song.save
    refute song.valid?
  end

  test "should save valid song" do
    song = Song.new
    song.name = 'Wish You Were Here'
    song.artist = 'Pink Floyd'
    song.album = 'Wish You Were Here [Remastered]'
    song.playlist = @playlist
    song.img_url = 'imageurl'

    song.save
    assert song.valid?
  end

end
