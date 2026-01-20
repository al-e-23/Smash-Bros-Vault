class RenameHasProjectillesToHasProjectilesInFighters < ActiveRecord::Migration[8.1]
  def change
    rename_column :fighters, :has_projectilles, :has_projectiles
  end
end
