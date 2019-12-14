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

  def search_songs

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
    request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
    request["x-rapidapi-key"] = '10aa7d7219mshc392ad81557b23bp1e6c60jsnf042b141ec03'

    response = http.request(request)
    result = JSON.parse(response.body)

    result['data'].each do |child|
      @song = @result.songs.new(name: child['title'],artist: child['artist']['name'],album: child['album']['title'], img_url: child['album']['cover_big'])
      @song.save
    end

    redirect_back(fallback_location: root_path)
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = @playlist.songs.new(song_params)

    respond_to do |format|
      if @song.save
        puts "song created"
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        puts "song not created"
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
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
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

    def set_result
      @result = Result.find_by(id: 1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.permit(:name, :artist, :album, :playlist_id, :img_url)
    end

end
