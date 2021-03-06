class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_booking, only: [:create, :new, :edit]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.booking = @booking
    if @review.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to user_dashboard_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to user_dashboard_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
