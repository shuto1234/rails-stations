class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new(
      # 値を元から入れるために以下のコードを記入
      schedule_id: params[:schedule_id],
      sheet_id: params[:sheet_id],
      date: params[:date]
    )

    @schedule_id = params[:schedule_id]
    @sheet_id = params[:sheet_id]
    @date = params[:date]
    @movie_id = params[:movie_id]
    

    if params[:sheet_id].blank? || params[:date].blank?
      redirect_to movies_id_path(params[:movie_id])
    end
 
  end

  def create
    Rails.logger.debug "schedule_id: #{@schedule_id}, date: #{@date}, movie_id: #{@movie_id}"

    @schedule = Schedule.find_by(params[:schedule_id])
    
    # 1.データを新規登録するためのインスタンス変数作成
    @reservation = Reservation.new(reservation_params)
    # 2.データをデータベースに保存するためのsaveメソッド
    if @reservation.save
      # 3.任意の  画面へリダイレクト
      if params[:movie_id].present?
        redirect_to movies_id_path(params[:movie_id])
      else
        redirect_to reservation_sheets_path(
          schedule_id: @reservation.schedule_id,
          date: @reservation.date,
          id: @schedule.movie_id
        )
      end
    else
      # 4.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
      render :new
    end
  end
  private
  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
  end
end
