class Queen < Piece
  def symbol
    game.white_player_id == user_id ? '&#9813;' : '&#9819;'  
  end
  
  #should return false if queen unable to move
  def valid_move?(new_row, new_column)
    #return false if unable to move
    return false if !super
    #returns only true if moved in a diagonal or a row or column unblocked
    
    return true if (new_row == self.position_row) || (new_column == self.position_column)
    delta_row = (new_row - position_row).abs
    delta_col = (new_column - position_column).abs
    
    return true if delta_row == delta_col 
    
    #If we don't have a valid move return false by default
    return false 
    
  end  
  
  
end 