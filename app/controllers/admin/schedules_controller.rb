# frozen_string_literal: true

module Admin
  class SchedulesController < ApplicationController
    def index
      # コメントアウトしてあるincludeを使う方法の方がN+1問題が発生しずらいため推奨されているが、仕組みが分かっていないため今回は不採用
      # @schedules = Schedule.includes(:movie)
      @schedules = Schedule.all
    end

    def show; end

    def new
      @scheduleNew = Schedule.new
    end

    def create
      # 1.データを新規登録するためのインスタンス変数作成
      @scheduleCreate = Schedule.new(schedule_params)
      # 2.movieに作成するscheduleの元となる映画を代入
      movie = Movie.find(params[:id])
      # 3.@scheduleCreateのmovie_idに先ほど取得した、映画のIDを代入
      @scheduleCreate.movie_id = movie.id
      # 4.データをデータベースに保存するためのsaveメソッド
      if @scheduleCreate.save
        # 5.任意の  画面へリダイレクト
        redirect_to admin_movies_show_path(@scheduleCreate.movie_id)
      else
        # 6.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
        render :new
      end
    end

    def edit
      @scheduleEdit = Schedule.find(params[:id])
    end

    def update
      # 1.データを編集するためのインスタンス変数作成
      @scheduleUpdate = Schedule.find(params[:id])
      # 2.編集したデータをデータベースに保存するためにupdateメソッド
      if @scheduleUpdate.update(schedule_params)
        # 3.任意の画面へリダイレクト
        redirect_to admin_movies_show_path(@scheduleUpdate.movie_id)
      else
        # 4.updateできなかったときに、admin::movies_controllerのeditのviewに飛ぶ
        render :edit
      end
    end

    def destroy
      # 1.データを1件取得
      schedule = Schedule.find(params[:id])
      # 2.データを削除
      schedule.destroy
      # 3.任意の画面へリダイレクト
      redirect_to admin_movies_show_path(schedule.movie_id)
    end

    private

    def schedule_params
      params.require(:schedule).permit(:movie_id, :start_time, :end_time)
    end
  end
end
