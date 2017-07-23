class Piece < ApplicationRecord
  belongs_to :game

  #return true if piece doesn't move and false if it does
  def no_move?(new_row, new_column)
    position_row == new_row && position_column == new_column
  end

  #return true if piece moves out of game boundaries and false if it doesn't

  def out_of_boundary?(new_row, new_column)
    new_row < 0 || new_row > 7 || new_column < 0 || new_column > 7
  end
  
  #checks for valid move
  def valid_move?(new_row, new_column)
    return false if out_of_boundary?(new_row, new_column)
    return false if no_move?(new_row, new_column)
  end

  def array_position(init, final)
    if init <= final
      array = (init...final).to_a
      array = array[1,array.length-1]
    else
      array = init.downto(final).to_a
      array = array[1, array.length-2]
    end
  end

  def is_obstructed?(row_final, col_final)
    row_init = self.position_row
    col_init = self.position_column
    row_range = array_position(row_init, row_final)
    col_range = array_position(col_init, col_final)
  
    #horizonal case
    if row_init == row_final
      return Piece.exists?(position_row: row_init, position_column: col_range, game_id: game_id)

      #vertical case
    elsif col_init == col_final 
      return Piece.exists?(position_row: row_range, position_column: col_init, game_id: game_id)

      #diagonal case
    elsif ((row_final - row_init).to_f/(col_final - col_init).to_f ).abs == 1
      i = 0
      row_range.each do |row_val|
        return true if Piece.exists?(position_row: row_val, position_column: col_range[i], game_id: game_id)
        i = i + 1
      end
    end

    #invalid input case
    return false
  end

  #Capture_Logic
  def move_to!(new_row, new_column)
    @pieces = Game.find(game_id).pieces
    @pieces.each do |piece|
      if piece.position_row == new_row && piece.position_column == new_column && piece.color != color
        piece.update_attributes(position_row: nil, position_column: nil)
        return true
      elsif piece.position_row == new_row && piece.position_column == new_column 
       return false
      end
    end
    return true
  end

  def moving_into_check?(new_row, new_column)
    #return false if the game is already in check before you try to move
    #return false if self.game.check?.first == self.color

    #We will switch to the new coordinates temporarily and see if we are in check if we move!
    current_row = self.position_row
    current_column = self.position_column
    self.update_attributes(position_row: new_row, position_column: new_column)
    #Get the status of check?
    status, culprit = self.game.check?
  
    #Revert to original position
    self.update_attributes(position_row: current_row, position_column: current_column)

    #**SPECIAL CASE**
    #Return false if we are moving to capture the piece that puts us in check
    return false if culprit && culprit.position_row == new_row && culprit.position_column == new_column
    #Return true if my king is in check
    return true if status == self.color
    #otherwise return false
    return false
  end  


end
