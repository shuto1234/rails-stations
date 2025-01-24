class MoviesController < ApplicationController
  def index

    @keyword = params[:keyword]
    @show = params[:is_showing]

    if @show == nil
      @movies = Movie.where('name LIKE ? or description LIKE ? ', "%#{@keyword}%" , "%#{@keyword}%") 
    elsif @show == "1" 
      @movies = Movie.where('name LIKE ? or description LIKE ? ', "%#{@keyword}%" , "%#{@keyword}%").where(is_showing: true)
    elsif @show == "0"
      @movies = Movie.where('name LIKE ? or description LIKE ? ', "%#{@keyword}%" , "%#{@keyword}%").where(is_showing: false)
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end

  def reservation
    @sheetsA = Sheet.where(row: 'a')
    @sheetsB = Sheet.where(row: 'b')
    @sheetsC = Sheet.where(row: 'c')
    @movie = Movie.find(params[:id])
    @schedule = Schedule.find(params[:schedule_id])
    @date = params[:date]

    if @date.nil? || @schedule.nil?
      flash[:alert] = "スケジュールと日付が必要です"
      redirect_to movie_path(@movie) and return
    end

    unless params[:schedule_id].present?
      redirect_to movie_path(@movie), alert: "スケジュールが必要です" and return
    end

    unless params[:date].present?
      redirect_to movie_path(@movie), alert: "日付が必要です。" and return
    end

  end

 

end
