class Rook < Piece
  def symbol
    game.white_player_id == user_id ? '&#9814;' : '&#9820;'  
  end
  
    #should return false if rook unable to move
  def valid_move?(new_row, new_column)
    #small clean up of this method 
    return false if !super
    #return false if rook is blocked
    return false if is_obstructed?(new_row, new_column)
    #returns only true if moved in a column or row and it is not obstructed or a no move 
    return true if (new_row == self.position_row) || (new_column == self.position_column)
    
    #If we don't have a valid move return false by default
    return false 
    
  end  
  
  

end 