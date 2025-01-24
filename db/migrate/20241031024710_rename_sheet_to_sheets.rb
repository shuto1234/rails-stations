class RenameSheetToSheets < ActiveRecord::Migration[7.1]
  def change
    rename_table :sheet, :sheets
  end
end
