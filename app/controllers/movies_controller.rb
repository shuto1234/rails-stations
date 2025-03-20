# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    search_movie
  end

  def show
    @movieShow = Movie.find(params[:id])
    @schedules = @movieShow.schedules
    @dates = (Date.today..Date.today + 7.days).to_a
    @reservationNew = Reservation.new

    return unless @movieShow.blank?

    render :index
  end

  def reservation
    redirect_to_date_or_schedule_id
    @movieShow = movie_find
    @schedule = schedule_find
    
    return redirect_to movies_id_path(params[:id]) if @schedule.nil?

    sheets
    set_day_or_week
  end

  private

  def search_by_keyword_and_showing(keyword, showing)
    if showing == 'true'
      Movie.where('is_showing = ?', true).where('name LIKE ? OR description LIKE ?', "%#{keyword}%",
                                                "%#{keyword}%")
    elsif showing == 'false'
      Movie.where('is_showing = ?', false).where('name LIKE ? OR description LIKE ?', "%#{keyword}%",
                                                 "%#{keyword}%")
    else
      Movie.where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
    end
  end

  def search_by_showing(showing)
    if showing == 'true'
      Movie.where('is_showing = ?', true)
    elsif showing == 'false'
      Movie.where('is_showing = ?', false)
    else
      Movie.all
    end
  end

  def search_movie
    # dig を使うことで、途中のキーやインデックスが存在しない場合でも、エラーが発生せず nil を返す。
    # params[:movie] が nil の場合、params[:movie][:keyword] でエラーが発生しますが、params.dig(:movie, :keyword) だと nil が返される。

    keyword = params.dig(:movie, :keyword)
    showing = params.dig(:movie, :search_showing)
    @movies = if keyword.present? && showing.present?
                # keyword = params[:movie][:keyword]
                # showing = params[:movie][:search_showing]
                search_by_keyword_and_showing(keyword, showing)
              elsif showing.present?
                # showing = params[:movie][:search_showing]
                search_by_showing(showing)
              else
                Movie.all
              end
  end

  def redirect_to_date_or_schedule_id
    redirect_to movies_id_path(params[:id]) if params[:date].blank? || params[:schedule_id].blank?
  end

  def movie_find
    Movie.find(params[:id])
  end

  def schedule_find
    Schedule.find(params[:schedule_id])
  end

  def sheets
    @sheetsA = Sheet.where(row: 'a')
    @sheetsB = Sheet.where(row: 'b')
    @sheetsC = Sheet.where(row: 'c')
  end

  def set_day_or_week
    # 曜日を日本語表記で表示するための関数
    require 'date'
    date = params[:date].to_date
    days = %w[日 月 火 水 木 金 土]
    @day_of_week = "(#{days[date.wday]})"
  end
end
