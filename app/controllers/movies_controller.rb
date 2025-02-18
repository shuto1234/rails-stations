class MoviesController < ApplicationController
  def index
    Rails.logger.debug params.inspect
    Rails.logger.debug "Search Word: #{params[:keyword]}"
    Rails.logger.debug "Params: #{params.inspect}"
    logger.debug "Params: #{params[:movie]}"
    logger.debug "is_showing: #{params[:search_showing]}"
    
    
    # @showing = params[:search_showing]
    # @ward = params[:keyword]
    # 全て、公開予定、公開中を判断する必要がある→is_showingが0or1,0,1の3パターンで表示を変える。
    # 映画のタイトルから映画を検索→入力された文字がnameと部分一致したものを取り出す。空欄は全て取り出す。

    # if params[:movie] && params[:movie][:keyword].present?
    #   showing = params[:movie][:search_showing]
    #   word = params[:movie][:keyword]
    #   @movies = Movie.search_movie(word, showing)
    # else
    #   @movies = Movie.all
    # end

    if params[:movie] && params[:movie][:keyword].present? && params[:movie][:search_showing].present?
      keyword = params[:movie][:keyword]
      showing = params[:movie][:search_showing]

      if showing == "true"
        @movies = Movie.where("is_showing = ?", true).where("name LIKE ? OR description LIKE ?" , "%#{keyword}%", "%#{keyword}%")
      elsif showing == "false"
        @movies = Movie.where("is_showing = ?", false).where("name LIKE ? OR description LIKE ?" , "%#{keyword}%", "%#{keyword}%")
      else
        @movies = Movie.where("name LIKE ? OR description LIKE ?" , "%#{keyword}%", "%#{keyword}%")
      end
    elsif params[:movie] && params[:movie][:keyword].blank? && params[:movie][:search_showing].present?
      showing = params[:movie][:search_showing]
      
      if showing == "true"
        @movies = Movie.where("is_showing = ?", true)
      elsif showing == "false"
        @movies = Movie.where("is_showing = ?", false)
      else
        @movies = Movie.all
      end
    else
      @movies = Movie.all
    end


    
  end

  def show
    @movieShow = Movie.find(params[:id])
  end

  # private
  # def movie_params
  #   params.require(:movie).permit(:keyword, :search_showing)
  # end
end