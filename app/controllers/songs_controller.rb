class SongsController < ApplicationController
  def index
       @artist = Artist.find_by(:id => params[:artist_id])
      if @artist
          @songs = @artist.songs
      elsif !params.include?(:artist_id)
          @songs = Song.all
      else
          redirect_to artists_path
      end
  end

  def show
      @artist = Artist.find_by(:id => params[:artist_id])
      @song = Song.find_by(:id => params[:id])
      if @artist.songs.include?(@song)
          
      elsif @song = Song.find_by(:id => params[:id])
          
      else
          flash[:alert] = "WOHW now cowboy. looks like this song doesn't exsist."
          redirect_to artist_songs_path @artist
      end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

