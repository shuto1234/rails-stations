class Schedule < ApplicationRecord
  belongs_to :movie

  validates :movie_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
