# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule
  belongs_to :screen
  belongs_to :user

  validates :schedule_id, presence: true
  validates :sheet_id, presence: true
  validates :date, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :user_id, presence: true

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'is not a valid email' }

  validates :sheet_id, uniqueness: { scope: %i[schedule_id date screen_id], message: 'この席はすでに予約されています。' }
end
