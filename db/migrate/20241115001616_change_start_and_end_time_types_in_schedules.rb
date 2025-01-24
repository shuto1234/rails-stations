class ChangeStartAndEndTimeTypesInSchedules < ActiveRecord::Migration[7.1]
  def change
    remove_column :schedules, :start_time
    remove_column :schedules, :end_time

    add_column :schedules, :start_time, :time
    add_column :schedules, :end_time, :time
  end
end
