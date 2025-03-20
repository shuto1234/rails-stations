# frozen_string_literal: true

class Sheet < ApplicationRecord
  has_many :reservations, dependent: :destroy
end
