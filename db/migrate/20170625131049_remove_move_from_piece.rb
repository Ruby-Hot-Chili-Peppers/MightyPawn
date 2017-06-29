class RemoveMoveFromPiece < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :move, :string
  end
end
