class AddMoveToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :move, :string
  end
end
