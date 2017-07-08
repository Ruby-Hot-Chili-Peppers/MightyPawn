class RemoveMoveFromPiece < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :move, :string, default: 0
  end
end
