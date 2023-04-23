class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.belongs_to :winner, foreign_key: { to_table: 'players' }
      t.boolean :draw

      t.timestamps
    end
  end
end
