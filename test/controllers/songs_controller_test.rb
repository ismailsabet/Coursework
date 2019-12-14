require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
  end

  test "should get index" do
    get songs_path
    assert_response :success
  end

  test "should get new" do
    get new_song_url(id: @song.playlist_id)
    assert_response :success
  end

  test "should create song" do
    assert_difference('Song.count') do
      post songs_url, params: { song: { album: @song.album, artist: @song.artist, name: @song.name, playlist_id: @song.playlist_id, id: @song.playlist_id } }
    end

    assert_redirected_to song_url(Song.last)
  end

  test "should show song" do
    get song_path(name: @song.name, artist: @song.artist, album: @song.album, playlist_id: @song.playlist_id, id: @playlist_id)
    assert_response :success
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete song_url(@song)
    end

    assert_redirected_to songs_url
  end
end
