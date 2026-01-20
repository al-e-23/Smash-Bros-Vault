class AddIntroducedInToFighters < ActiveRecord::Migration[8.1]
  def change
    add_column :fighters, :introduced_in, :string
  end
end
