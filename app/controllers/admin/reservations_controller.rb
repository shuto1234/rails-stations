# frozen_string_literal: true

module Admin
  class ReservationsController < ApplicationController
    def index
      @reservations = Reservation.all
    end

    def new
      @reservation = Reservation.new
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
      params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email, :screen_id, :user_id)
    end
  end
end
