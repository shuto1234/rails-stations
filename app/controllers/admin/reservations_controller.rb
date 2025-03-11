class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @movies = Movie.all
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
    

    # if params[:sheet_id].blank? || params[:date].blank?
    #   redirect_to movies_id_path(params[:movie_id])
    # 

    @dates = (Date.today..Date.today + 7.days).to_a
 
  end

  def create
    # 1.データを新規登録するためのインスタンス変数作成
    @reservation = Reservation.new(reservation_params)
    # 2.データをデータベースに保存するためのsaveメソッド
    if @reservation.save
      # 3.任意の  画面へリダイレクト
      redirect_to admin_reservations_path
    else
      # 4.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
      render :new, status: :bad_request
    end
  end
  
  def show
    @reservation = Reservation.find(params[:id])
    @movies = Movie.all
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path
    else
      render :edit
    end
  end
  
  def destroy
    # 1.データを1件取得
    reservation = Reservation.find(params[:id])
    # 2.データを削除
    reservation.destroy
    # 3.任意の画面へリダイレクト
    redirect_to admin_reservations_path
  end
  
  private
  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
  end
  
end
