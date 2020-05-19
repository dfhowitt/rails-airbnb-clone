class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :destroy]
  before_action :find_property, only: [:create, :new]

  def index
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.property = @property
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to property_path(@booking.property)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def find_property
    @property = Property.find(params[:property_id])
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
