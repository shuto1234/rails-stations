class ChangeResevationToReservation < ActiveRecord::Migration[7.1]
  def change
    rename_table :resevations, :reservations
  end
end
