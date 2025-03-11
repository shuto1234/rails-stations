class AddScreenIdToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :screen_id, :string
  end
end
