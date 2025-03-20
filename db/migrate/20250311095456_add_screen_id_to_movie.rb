# frozen_string_literal: true

class AddScreenIdToMovie < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :screen_id, :string, null: false
  end
end
