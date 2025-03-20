# frozen_string_literal: true

class RemoveScreenIdFromReservations < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :screen_id, :string
  end
end
