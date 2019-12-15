class SongsController < ApplicationController
  before_action :set_playlist, only: [:new, :create]
  before_action :set_result, only: [:search_songs, :new]
  before_action :set_song, only: [:show, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.inPlaylist
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
  end

  # Uses Deezer API to execute a search
  def search_songs

    # Replaces current search result with an empty one. There should always be only 1 result.
    # This is why seeding first is important.
    @result.destroy
    @result = Result.new(id: 1, name: 'init')
    @result.save

    require 'uri'
    require 'net/http'
    require 'openssl'
    require 'json'
    keyword = params[:search]

    url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{keyword}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = I18n.t('songs.api_host')
    request["x-rapidapi-key"] = I18n.t('songs.api_key')

    response = http.request(request)
    result = JSON.parse(response.body)

    # You can check the layout of the JSON by going to rapidapi website and testing the endpoints.
    result['data'].each do |child|
      @song = @result.songs.new(name: child['title'],artist: child['artist']['name'],album: child['album']['title'], img_url: child['album']['cover_big'])
      @song.save
    end

    # reloads page to show result
    redirect_back(fallback_location: root_path)
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = @playlist.songs.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: I18n.t('songs.created') }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to playlists_path, notice: I18n.t('songs.deleted') }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find_by(id: params[:playlist_id]) || Playlist.find(song_params[:playlist_id])
    end

    # Finds the current search result (will always have an id of 1)
    def set_result
      @result = Result.find_by(id: 1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.permit(:name, :artist, :album, :playlist_id, :img_url)
    end

end
