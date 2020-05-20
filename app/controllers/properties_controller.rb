class PropertiesController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]

  def index
    @properties = Property.geocoded

    @markers = @properties.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { property: property })
      }
    end
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to property_path(@property)
      flash.alert = "You just created #{@property.name}!  "


    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to property_path(@property)
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path
  end

  private

  def find
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:owner_id, :type, :location, :name, :description, :price, :capacity, :availability, photos: [])
  end
end
