class Knight < Piece
  def symbol
    game.white_player_id == user_id ? '&#9816;' : '&#9822;'  
  end

   #should return false if move is greater than 1 space
  def proper_length?(new_row, new_column)
    delta_row = (new_row - position_row).abs
    delta_col = (new_column - position_column).abs
    ((delta_row == 1) && (delta_col == 2)) || ((delta_row == 2) && (delta_col == 1))
  end
end 