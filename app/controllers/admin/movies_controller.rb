class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
  def new
    @movie = Movie.new
  end
  def create
    # 1.データを新規登録するためのインスタンス変数作成
    @movie = Movie.new(movie_params)
    # 2.データをデータベースに保存するためのsaveメソッド
    if @movie.save
      # 3.任意の  画面へリダイレクト
      redirect_to admin_movies_path
    else
      # 4.saveできなかったときに、admin::movies_controllerのnewのviewに飛ぶ
      render :new
    end
  end
  def edit
    @movieEdit = Movie.find(params[:id])
  end
  def update
    # 1.データを編集するためのインスタンス変数作成
    @movieEdit = Movie.find(params[:id])
    # 2.編集したデータをデータベースに保存するためにupdateメソッド
    if @movieEdit.update(movie_params)
      # 3.任意の画面へリダイレクト
      redirect_to admin_movies_index_path
    else
      # 4.updateできなかったときに、admin::movies_controllerのeditのviewに飛ぶ
      render :edit
    end
  end 

  private
  
  # ストロングパラメータ
  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end
