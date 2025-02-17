class Movie < ApplicationRecord
  # name,year,is_showing がnilの場合エラーを出す。
  validates :name, presence: true
  validates :year, presence: true
  validates :is_showing, presence: true
  
  # nameの一意性を保つ
  validates :name ,uniqueness: true

  # scope :search_movie, ->(keyword) {
  #   where("name LIKE ?", "%#{keyword}%") if keyword.present?
  # }
  def self.search_movie(word, showing)
    if showing == "true"
      Movie.where("is_showing = ?", true)
        Movie.where("name LIKE ? OR description LIKE ?" , "%#{word}%", "%#{word}%")
    elsif showing == "false"
      Movie.where("is_showing = ?", false)
        Movie.where("name LIKE ? OR description LIKE ?" , "%#{word}%", "%#{word}%")
    else
      Movie.where("name LIKE ? OR description LIKE ?" , "%#{word}%", "%#{word}%")
    end
  end
end
