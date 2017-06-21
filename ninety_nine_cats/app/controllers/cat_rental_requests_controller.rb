class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(crr_params)
    if @cat_rental_request.save
      redirect_to cat_rental_requests_url
    else
      render json: @cat_rental_request.errors.full_messages, status: 400
    end
  end


  private
  def crr_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
