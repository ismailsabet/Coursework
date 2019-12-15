require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase

  test "should not save empty playlist" do
    playlist = Playlist.new

    playlist.save
    refute playlist.valid?
  end

  test "should save valid playlist" do
    playlist = Playlist.new
    playlist.name = 'Chill'

    playlist.save
    assert playlist.valid?
  end

  test "should not save playlist duplicate name" do
    playlist = Playlist.new
    playlist.name = 'Rock'

    playlist.save
    refute playlist.valid?
  end

end
