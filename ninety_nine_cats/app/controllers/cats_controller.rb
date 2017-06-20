class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render json: @cats
  end

  def show
    @cats.find_by(id: params[:id])

    render cat_params
  end






  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

end
