# frozen_string_literal: true

class Reservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.integer :schedule_id, null: false
      t.integer :sheet_id, null: false
      t.string :email, null: false, limit: 255, comment: '予約者メールアドレス'
      t.string :name, null: false, limit: 50, comment: '予約者名'

      t.timestamps
      # ユニークインデックスの設定。まだわからないため、今回は実装しない
      # t.index :schedule_id
      # t.index :sheet_id
      # t.index [:date, :schedule_id, :sheet_id], unique: true
    end
    # うまく処理が実行されていなかったから、一旦消している
    # add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true
  end
end
