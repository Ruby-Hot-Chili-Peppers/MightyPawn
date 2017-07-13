class Knight < Piece
  def symbol
    game.white_player_id == user_id ? '&#9816;' : '&#9822;'  
  end

  def valid_move?(new_row, new_column)
    return false if super == false
    delta_row = (new_row - position_row).abs
    delta_col = (new_column - position_column).abs
    return false unless ((delta_row == 1) && (delta_col == 2)) || ((delta_row == 2) && (delta_col == 1))
    true
  end
end 