class UsersController < ApplicationController
  before_action :set_user

  def properties
    @properties = @user.properties
    @properties_with_stars = @properties.map do |property|
      {property: property, average_rating: stars(property)[:average_rating], blank_stars: stars(property)[:blank_stars]}
    end
  end

  def bookings
    @bookings = @user.bookings
  end

  def dashboard
    @bookings = @user.bookings
    @properties = @user.properties
    @reviews = @user.reviews
  end

  def reviews
    @reviews = Review.where(user_id: @user)

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

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
end
