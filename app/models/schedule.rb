# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy

  validates :movie_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
