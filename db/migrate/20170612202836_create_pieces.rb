class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :position_row
      t.integer :position_column
      t.integer :user_id
      t.integer :game_id
      t.string :color
      t.string :type

      t.timestamps
    end
  end
end
