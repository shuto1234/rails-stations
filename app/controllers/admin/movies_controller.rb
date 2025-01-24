class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:schedules).all
    
  end
  def new 
    @movie = Movie.new
  end 
  def create
    movie = Movie.new(movie_params)
    movie.save
    redirect_to admin_movies_path
  end
  def edit
    @movie = Movie.find(params[:id])
  end
  def update
    movie = Movie.find(params[:id])
    movie.update(movie_params)
    redirect_to admin_movies_path
  end
  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    redirect_to admin_movies_path
  end
  def show
    @movie = Movie.find(params[:id])
  end

  private
  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end 
end
