class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.boolean :ready
      t.references :user, null: false, foreign_key: true
      t.references :parite_game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
