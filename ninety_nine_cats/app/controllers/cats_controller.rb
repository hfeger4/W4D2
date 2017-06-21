class CatsController < ApplicationController

  def new
    @cat = Cat.new
    render :new
  end
  def index
    @cats = Cat.all
    render :index
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 400
    end

  end

  def show
    @cat = selected_cat
    @cat_requests = cat_requests

    if @cat
      render :show
    else
      render json: ["No cat can be found "], status: 404
    end
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cats_url
    else
      render json: @cat.errors.full_messages, status: 400
    end
  end

  def edit
    @cat = selected_cat
    render :edit
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

  def selected_cat
    Cat.find_by(id: params[:id])
  end

  def cat_requests
    CatRentalRequest.where(cat_id: params[:id])
  end

end
