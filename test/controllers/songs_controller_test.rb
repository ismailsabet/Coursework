require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
    @playlist = playlists(:one)
  end

  test "should get index" do
    get songs_path
    assert_response :success
  end

  test "should show song" do
    get song_path(@song)
    assert_response :success
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete song_url(@song)
    end

    assert_redirected_to songs_url
  end
end
