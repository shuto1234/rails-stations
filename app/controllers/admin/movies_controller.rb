class Admin::MoviesController < ApplicationController
  def index
    @movies = Admin::Movie.all
  end
  def new
    @movie = Admin::Movie.new
  end 
  def create
    @movie = Admin::Movie.new(movie_params)
    if @movie.save
      # redirect_to 'admin/movie'
      render :new
    else
      redirect_to 'admin/movie'
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing,)
  end
end
