class Schedule < ApplicationRecord
  belongs_to :movie
  # validates :movie_id, presence: true

  validates :start_time, :end_time, presence: true

  has_many :reservations, dependent: :destroy
  
#   validates :start_time, presence: true
# validates :end_time, presence: true
# validate :end_time_must_be_after_start_time

# def end_time_must_be_after_start_time
#   return if end_time.blank? || start_time.blank?

#   if end_time <= start_time
#     errors.add(:end_time, "must be after the start time")
#   end
end
