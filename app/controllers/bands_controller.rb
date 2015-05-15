class BandsController < ApplicationController
  def create
    @band = Band.create(band_params)

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def destroy

  end

  def edit

  end

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def update

  end

  private

    def band_params
      params.require(:band).permit(:name)
    end

end
