class CreateResevations < ActiveRecord::Migration[7.1]
  def change
    create_table :resevations do |t|
      t.date :date
      t.integer :schedule_id
      t.integer :sheet_id
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
