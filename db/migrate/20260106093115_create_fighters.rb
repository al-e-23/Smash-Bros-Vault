class CreateFighters < ActiveRecord::Migration[8.1]
  def change
    create_table :fighters do |t|
      t.string :character
      t.boolean :has_spike
      t.boolean :has_projectilles
      t.boolean :has_counter
      t.boolean :has_reflector

      t.timestamps
    end
  end
end
