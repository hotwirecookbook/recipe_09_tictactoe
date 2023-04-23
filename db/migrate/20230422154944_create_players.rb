class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :symbol
      
      t.timestamps
    end
  end
end
