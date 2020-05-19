class UsersController < ApplicationController
  before_action :set_user

  def properties
    @properties = Property.where(user: @user)
  end

  def bookings
    @bookings = Booking.where(user: @user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
