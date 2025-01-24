class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.integer :movie_id
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
