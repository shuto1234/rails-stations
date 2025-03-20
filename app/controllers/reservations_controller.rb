# frozen_string_literal: true

class ReservationsController < ApplicationController
  def new
    @movie = find_movie
    return redirect_to root_path if @movie.nil?

    @reservation = Reservation.new

    redirect_if_invalid_params
  end

  def create
    @schedule = Schedule.find_by(params[:schedule_id])

    # 1.データを新規登録するためのインスタンス変数作成
    @reservation = Reservation.new(reservation_params)

    if invalid_user?
      render :new
      return

    end
    # 2.データをデータベースに保存するためのsaveメソッド
    if @reservation.save
      movie_present?
      # 3.任意の  画面へリダイレクト
    else
      # 4.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
      render :new
    end
  end

  private

  def find_movie
    Movie.find_by(id: params[:movie_id])
  end

  def redirect_if_invalid_params
    return unless params[:sheet_id].blank? || params[:date].blank?
    redirect_to movies_id_path(params[:movie_id])
  end
  
  def invalid_user?
    current_user.email != @reservation.email || current_user.name != @reservation.name
  end

  def movie_present?
    if params[:movie_id].present?
      redirect_to movies_id_path(params[:movie_id])
    else
      redirect_to reservation_sheets_path
    end
  end

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email, :screen_id, :user_id)
  end
end
