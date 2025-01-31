class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end
  def new 
    @schedule = Schedule.new
  end 
  def create
      # 時刻のみを文字列として保存
  start_time = schedule_params[:start_time]
  end_time = schedule_params[:end_time]

  # 新しいスケジュールを作成
  @schedule = Schedule.new(schedule_params.merge(start_time: start_time, end_time: end_time))

  # 保存に成功した場合
  if @schedule.save
    redirect_to admin_movies_path, notice: 'スケジュールが作成されました。'
  else
    render :new
  end

  end
  def edit
    @schedule = Schedule.find(params[:id])
  end
  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update(schedule_params)
    redirect_to admin_movies_path
  end
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to admin_movies_path
  end

  private
  def schedule_params
    params.require(:schedule).permit(:movie_id, :start_time, :end_time)
  end 
end
