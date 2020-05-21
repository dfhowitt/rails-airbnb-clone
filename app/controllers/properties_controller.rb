class PropertiesController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]

    query_geocoder_results = Geocoder.search(@query)
    query_coords = query_geocoder_results.first&.coordinates

    @properties = Property.geocoded.near(@query, 50)
    @results = true

    if @properties.empty? || !query_coords
      @results = false
      @properties = Property.geocoded
    end

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
    @property.user_id = current_user.id


    if @property.save
      if params[:property][:service_ids].reject(&:blank?).any?
        create_post_category(@property.id, params[:property][:service_ids].reject(&:blank?))
      end
      redirect_to property_path(@property)
      flash.alert = "You just created #{@property.name}!  "
    else
      render :new
    end
  end


  def edit
  end

  def update
    @property.services.destroy_all

    if @property.update(property_params)
      if params[:property][:service_ids].reject(&:blank?).any?
        create_post_category(@property.id, params[:property][:service_ids].reject(&:blank?))
      end
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

  def create_post_category(property, services)
    services.each do |service|
      PropertyService.create(property_id: property, service_id: service.to_i)
    end
  end

  def find
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:property_type, :location, :name, :description, :price, :capacity, :availability, :service_ids, photos: [])
  end
end
