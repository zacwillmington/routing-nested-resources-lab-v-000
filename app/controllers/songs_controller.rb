class SongsController < ApplicationController
  def index
      binding.pry
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
      binding.pry
      @artist = Artist.find_by(:id => params[:artist_id])
      @song = @artist.songs.find_by(:id => params[:id])
      if @song
          binding.pry
      elsif @song = Song.find(params[:id])
          binding.pry
      else
          binding.pry
          flash[:notice] = "WOHW now cowboy. looks like this song doesn't exsist."
          redirect_to artist_path @artist
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

