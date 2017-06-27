class Pawn < Piece
  def symbol
    game.white_player_id == user_id ? '&#9817;' : '&#9823;'  
  end

  def valid_move?(new_row, new_column)
    #return false if you didnt move of if the move is obstructed
    return false if no_move?(new_row, new_column)
    return false if is_obstructed?(new_row, new_column)

    #------------------------------------WHITE PIECE LOGIC--------------------------------------------#
    if color == "black"
      #initial move can be 2 up
      if moves == 0
        #Check to see if there is a piece on the spot two ahead
        @two_ahead = Game.find(game_id).pieces.where(:position_row => position_row - 2, :position_column => position_column)
        #Only return true if we don't have a piece on the spot two ahead
        return true if new_row == position_row - 2  && new_column == position_column && @two_ahead.size == 0
      end

      #check to see if there is a piece on the spot one ahead, regardless of what move (including move = 0)
      @one_ahead = Game.find(game_id).pieces.where(:position_row => position_row - 1, :position_column => position_column)
      #Only return true if we don't have a piece on the spot straight ahead
      return true if new_row == position_row - 1 && new_column = position_column && @one_ahead.size == 0
      
      #we capture things diagonally, first figure out if a piece of the opposing color is diagonal
      #If the piece is the same color, it won't be a valid move
      @diag_right = Game.find(game_id).pieces.where(:color => 'white', :position_row => position_row - 1, :position_column => position_column + 1)
      @diag_left = Game.find(game_id).pieces.where(:color => 'white', :position_row => position_row - 1, :position_column => position_column - 1)
      #If there exists an opposing piece diagonally, we can move to the spot 
      if @diag_right.size != 0
        return true if new_row == position_row + 1 && new_column = position_column + 1 
      elsif @diag_left.size != 0
        return true if new_row == position_row + 1 && new_column = position_column - 1 
      end
    #------------------------------------BLACK PIECE LOGIC--------------------------------------------#
    else
      #initial move can be up 2
      if moves == 0
        #Check to see if there is a piece on the spot two ahead
        @two_ahead = Game.find(game_id).pieces.where(:position_row => position_row + 2, :position_column => position_column)
        #Only return true if we don't have a piece on the spot two ahead
        return true if new_row == position_row + 2  && new_column == position_column && @two_ahead.size == 0
      end 

      #check to see if there is a piece on the spot one ahead, regardless of what move (including move = 0)
      @one_ahead = Game.find(game_id).pieces.where(:position_row => position_row + 1, :position_column => position_column)
      #Only return true if we don't have a piece on the spot straight ahead
      return true if new_row == position_row + 1  && new_column == position_column && @one_ahead.size == 0 
      
      #we capture things diagonally, first figure out if a piece of the opposing color is diagonal
      #If the piece is the same color, it won't be a valid move
      @diag_right = Game.find(game_id).pieces.where(:color => 'black', :position_row => position_row + 1, :position_column => position_column + 1)
      @diag_left = Game.find(game_id).pieces.where(:color => 'black', :position_row => position_row + 1, :position_column => position_column - 1)
      #If there exists an opposing piece diagonally, we can move to the spot 
      if @diag_right.size != 0
        return true if new_row == position_row + 1 && new_column == position_column + 1
      elsif @diag_left.size != 0
        return true if new_row == position_row + 1 && new_column == position_column - 1
      end
    end

    #If we don't have a valid move
    return false
  end
end


