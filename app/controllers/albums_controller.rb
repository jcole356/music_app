class AlbumsController < ApplicationController
  def create
    @album = Album.create(album_params)

    if @album.save
      redirect_to albums_url
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    render :new
  end

  def show

  end

  private

    def album_params
      params.require(:album).permit(:name, :band_id)
    end
end
