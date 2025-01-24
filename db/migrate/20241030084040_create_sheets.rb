class CreateSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :sheets do |t|
      #TINYINTとして扱うためにlimitを指定。完全にtinyintと同じとはいかない
      t.integer :column, limit: 1 
      # limit => 1 でVARCHAR(1)として定義。好きな数値を入れて範囲を決める。
      t.string :row, limit: 1 
      t.timestamps
    end
  end
end
