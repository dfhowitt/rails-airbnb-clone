class PropertiesController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]

  def index
    @query = params[:query]

    query_geocoder_results = Geocoder.search(@query)
    query_coords = query_geocoder_results.first&.coordinates

    @properties = Property.geocoded.near(@query, 50)
    @properties_with_stars = @properties.map do |property|
      {property: property, average_rating: stars(property)[:average_rating], blank_stars: stars(property)[:blank_stars]}
    end
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
    @average_rating = stars(@property)[:average_rating]
    @blank_stars = stars(@property)[:blank_stars]
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
    redirect_to user_properties_path(current_user)
  end

  private

  def stars(property)
    ratings = []
    sum = 0
    property.reviews.each do |review|
      ratings << review.rating
    end
    ratings.each do |rating|
      sum += rating.to_i
    end
    unless ratings.empty?
      average_rating = sum/ratings.length
      blank_stars = 5 - average_rating.to_i
      return {average_rating: average_rating, blank_stars: blank_stars}
    end
    return {average_rating: nil, blank_stars: nil}
  end

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
