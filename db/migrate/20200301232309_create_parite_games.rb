class CreatePariteGames < ActiveRecord::Migration[6.0]
  def change
    create_table :parite_games do |t|
      t.string :title
      t.references :lobby, null: false, foreign_key: true

      t.timestamps
    end
  end
end
