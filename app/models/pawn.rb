class Pawn < Piece
  def symbol
    game.white_player_id == user_id ? '&#9817;' : '&#9823;'  
  end

  def valid_move?(new_row, new_column)
    #return false if you didnt move
    return false if position_row == new_row && position_column == new_column
    #return false if our path is obstructed
    return false if is_obstructed?(new_row, new_column)

    #If the piece is white the row must decrease
    if color == "white"
      #initial move can move 2
      return true if moves == 0 && new_row == position_row - 2  && new_column == position_column 
      #regular move
      return true if new_row == position_row- 1 && new_column = position_column 
    #If the piece is black the row must increase
    else
      #initial move can move 2
      return true if moves == 0 && new_row == position_row + 2  && new_column == position_column 
      #regular move
      return true if new_row == position_row + 1  && new_column = position_column 
    end

    #If we don't have a valid move
    return false
  end
end


