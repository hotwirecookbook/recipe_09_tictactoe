class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.belongs_to :game, null: false, foreign_key: true
      t.belongs_to :player, null: false, foreign_key: true
      t.integer :move_number, null: false, default: 0
      t.integer :position

      t.timestamps
    end
  end
end
