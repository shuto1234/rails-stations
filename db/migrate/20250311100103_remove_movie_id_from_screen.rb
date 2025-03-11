class RemoveMovieIdFromScreen < ActiveRecord::Migration[7.1]
  def change
    remove_column :screens, :movie_id, :string
  end
end
