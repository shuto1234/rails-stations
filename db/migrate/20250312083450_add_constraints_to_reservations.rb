# frozen_string_literal: true

class AddConstraintsToReservations < ActiveRecord::Migration[7.1]
  def change
    # 外部キー制約を削除
    remove_foreign_key :reservations, :users

    # 必要に応じて、user_idカラムの型変更を元に戻す
    # 例えば、stringに戻す場合は次のように記述
    change_column :reservations, :user_id, :string, null: false
  end
end
