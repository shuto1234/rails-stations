class ReservationsController < ApplicationController
  # before_action :set_movie
  before_action :set_schedule


  def new
    
    @movie = @schedule.movie
    @schedule = Schedule.find(params[:schedule_id])
    # @sheet = Sheet.find_by(id: params[:sheet_id])
    @sheet = params[:sheet_id]
    @date = params[:date]
    @reservation = Reservation.new

    unless @schedule
      head :not_found # 404 Not Found を返す
      return
    end
  
    # 必須のパラメータが不足している場合は404を返す
    if params[:date].blank? || params[:sheet_id].blank?
      head :not_found # 404 Not Found を返す
      return
    end

    # if params[:date].blank? || params[:schedule_id].nil?
    #   flash[:alert] = "スケジュールと日付が必要です"
    #   redirect_to movie_path(@movie) and return
    # end
    
    if params[:date].blank? || @sheet.nil?
      flash[:alert] = "スケジュールと日付が必要です"
      redirect_to movie_path(@movie) and return
    end
    
    # if params[:schedule_id].nil?
    #   flash[:alert] = "スケジュールが必要です"
    #   redirect_to movie_path(@movie) and return
    # end

    if @sheet.nil?
      flash[:alert] = "スケジュールが必要です"
      redirect_to movie_path(@movie) and return
    end
  end

  def create
    @movie = @schedule.movie
    @reservation = @schedule.reservations.build(reservation_params)

    # @movie を使って予約確認やログに記録する例
    Rails.logger.info "Reservation created for Movie: #{@movie.name}"

    if Reservation.exists?(schedule_id: @schedule.id, sheet_id: params[:sheet_id], date: params[:date])
      flash[:alert] = "この座席はすでに予約されています。別の座席を選んでください。"
      redirect_to reservation_movie_path(@movie, schedule_id: @schedule.id, date: params[:date]) and return
    end

    # @reservation = Reservation.new(reservation_params)
    if 
      @reservation.save
      flash[:success] = "予約が完了しました。"
      redirect_to movie_path(@schedule.movie) and return
    else
      flash[:alert] = @reservation.errors.full_messages.join(", ")
      Rails.logger.debug(@reservation.errors.full_messages)
      redirect_to reservation_movie_path(
        id: @reservation.schedule.movie.id, 
        schedule_id: @reservation.schedule.id, 
        date: @reservation.date
        ) and return
    end

    # if params[:date].blank? && params[:schedule_id].nil?
    #   flash[:alert] = "スケジュールと日付が必要です"
    #   redirect_to movie_path(@movie) and return
    # end
    
    if params[:date].blank?
      flash[:alert] = "座席番号と日付が必要です"
      redirect_to movie_path(@movie) and return
    end
    
    if @schedule.schedule_id.blank?
      flash[:alert] = "スケジュールが必要です"
      redirect_to movie_path(@movie) and return
    end
  end

  private
  
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
  
  # スケジュールの設定
  def set_schedule
    # if params[:schedule_id].nil?
    #   flash[:alert] = "スケジュールが必要です"
    #   redirect_to movie_path(@movie) and return
    # else
      @schedule = Schedule.find_by(id: params[:schedule_id])
    #   if @schedule?
    #     flash[:alert] = "スケジュールが見つかりません"
    #     redirect_to movie_path(@movie) and return
    #   end
    # end
  end


  def handle_failed_reservation
    redirect_to movie_reservation_path(@reservation.schedule.movie.id,
                                     schedule_id: @reservation.schedule_id)
    flash[:error] = 'その座席はすでに予約済みです'
  end

  def handle_unique_violation
    flash[:error] = 'その座席はすでに予約済みです'
    redirect_to new_reservation_path(movie_id: @reservation.schedule.movie.id,
                                     schedule_id: @reservation.schedule_id)
  end

  
  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :email, :name)
  end


  
end
