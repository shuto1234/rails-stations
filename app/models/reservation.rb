class Reservation < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }}
  
  belongs_to :sheet
  belongs_to :schedule

  validates :date, presence: true
  validates :schedule_id, presence: true
  validates :sheet_id, presence: true
  # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: 50 }
  # validates :date, uniqueness: { scope: [:schedule_id, :sheet_id] }


  validate :unique_seat_per_schedule

  private

  # 重複チェックのロジック
  def unique_seat_per_schedule
    if Reservation.exists?(schedule_id: schedule_id, sheet_id: sheet_id, date: date)
      errors.add(:base, "その座席はすでに予約済みです")
    end
  end

end
