# frozen_string_literal: true

class Screen < ApplicationRecord
  validates :number, presence: true

  has_many :reservations, dependent: :destroy
  has_many :movies, dependent: :destroy
end
