class AddMovesToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :moves, :integer
  end
end
