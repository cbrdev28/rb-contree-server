class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.boolean :face_up
      t.string :color
      t.integer :value
      t.references :player, foreign_key: true
      t.references :parite_game, foreign_key: true

      t.timestamps
    end
  end
end
