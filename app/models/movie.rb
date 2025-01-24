class Movie < ApplicationRecord
  validates :name, uniqueness: true

  has_many :schedules, dependent: :destroy
  # has_many :sheets, dependent: :destroy
  # has_many :reservations, dependent: :destroy

  # validates :date, presence: true
  # validates :schedule_id, presence: true
end
