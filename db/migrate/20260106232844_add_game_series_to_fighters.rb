class AddGameSeriesToFighters < ActiveRecord::Migration[8.1]
  def change
    add_column :fighters, :game_series, :string
  end
end
