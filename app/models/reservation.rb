class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule

  validates :schedule_id, presence: true
  validates :sheet_id, presence: true
  validates :date, presence: true
  validates :name, presence: true
  validates :email, presence: true

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "is not a valid email" }
end
