class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :destroy]
  before_action :find_property, only: [:index, :create, :new]

  def index
    @booking = Booking.where(user: @property.user)
  end

  def show
    @length = @booking.end_date - @booking.start_date
    @total_price = @booking.property.price * @length
    @property = @booking.property
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.property = @property
    @booking.user = current_user
    if @booking.save
      redirect_to user_dashboard_path(current_user)
      flash.alert = "You are staying at #{@property.name}!  "

    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to user_dashboard_path(current_user)
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
