class UsersController < ApplicationController
  before_action :set_user

  def properties
    @properties = @user.properties
  end

  def bookings
    @bookings = @user.bookings
  end

  def dashboard
    @bookings = @user.bookings
    @properties = @user.properties
    @reviews = @user.reviews
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
