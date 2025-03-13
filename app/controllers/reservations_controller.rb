class ReservationsController < ApplicationController
  def new
    @movie = Movie.find_by(id: params[:movie_id])
    if @movie.nil?
      return redirect_to root_path
    end
    
    @reservation = Reservation.new(
      # 値を元から入れるために以下のコードを記入
      schedule_id: params[:schedule_id],
      sheet_id: params[:sheet_id],
      date: params[:date],
      screen_id: @movie.screen_id,
      name: current_user.name,
      email: current_user.email
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
    @movie = Movie.find(params[:movie_id])
    Rails.logger.debug "schedule_id: #{@schedule_id}, date: #{@date}, movie_id: #{@movie_id}"

    @schedule = Schedule.find_by(params[:schedule_id])
    
    # 1.データを新規登録するためのインスタンス変数作成
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.email = current_user.email
    @reservation.name = current_user.name
    @user = User.find(@reservation.user_id)

    if @user.email != params[:email] && @user.name != params[:name]
      render :new
      return
    end
    # 2.データをデータベースに保存するためのsaveメソッド
    if @reservation.save
      # 3.任意の  画面へリダイレクト
      if params[:movie_id].present?
        redirect_to movies_id_path(params[:movie_id])
        return
      else
        redirect_to reservation_sheets_path(
          schedule_id: @reservation.schedule_id,
          date: @reservation.date,
          id: @schedule.movie_id,
          screen_id: @movie.screen_id,
          name: @reservation.name,
          email: @reservation.email
        )
        return
      end

    else
      # 4.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
      render :new
      return
    end
  end
  private
  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email, :screen_id, :user_id)
  end
end
