class Movie < ApplicationRecord
  # name,year,is_showing がnilの場合エラーを出す。
  validates :name, presence: true
  validates :year, presence: true
  # validates :is_showing, presence: true
  
  # nameの一意性を保つ
  validates :name ,uniqueness: true

  has_many :schedules, dependent: :destroy
  has_many :reservations, dependent: :destroy

end
