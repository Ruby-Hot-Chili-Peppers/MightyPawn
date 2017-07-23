class Bishop < Piece
  def symbol
    game.white_player_id == user_id ? '&#9815;' : '&#9821;'  
  end
  
  #should return false if rook unable to move
  def valid_move?(new_row, new_column)

    return false if super == false
    #return false if bishop is blocked

    return false if is_obstructed?(new_row, new_column)
   
    #returns true if moved diagonally
    delta_row = (new_row - position_row).abs
    delta_col = (new_column - position_column).abs
    return true if delta_row == delta_col 
    return false
  end  

end