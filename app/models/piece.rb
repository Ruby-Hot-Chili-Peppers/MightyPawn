class Piece < ApplicationRecord
  belongs_to :game

  #return true if piece doesn't move and false if it does
  def no_move?(new_row, new_column)
    position_row == new_row && position_column == new_column
  end

  #return true if piece moves out of game boundaries and false if it does
  def out_of_boundary?(new_row, new_column)
    new_row < 0 || new_row > 7 || new_column < 0 || new_column > 7
  end
   
  #check if piece moves to occupied space
  def occupied_space?
  end
   
  #check if piece captures other piece after moving into new space
  def captured_piece?
  end
   
  #check if move puts opponent in check
  def check?
  end
   
  #check if moves puts current_user in check 
  def self_in_check?
  end
   
  #check if move puts opponent in check_mate
  def check_mate?
  end
   
  #checks for valid move
  def valid_move?(new_row, new_column)
    return false if out_of_boundary?(new_row, new_column)
    return false if no_move?(new_row, new_column)
    return false unless proper_length?(new_row, new_column)
    true
  end

  def array_position(init, final)
    if init <= final
      array = (init...final).to_a
      array = array[1,array.length]
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
      return Piece.exists?(position_row: row_init, position_column: col_range)

      #vertical case
    elsif col_init == col_final 
      return Piece.exists?(position_row: row_range, position_column: col_init)

      #diagonal case
    elsif ((row_final - row_init).to_f/(col_final - col_init).to_f ).abs == 1
      return Piece.exists?(position_row: row_range, position_column: col_range)
    end

    #invalid input case
    raise RuntimeError, "invalid input. Not diagnal, horizontal, or vertical."
  end

  #Capture_Logic
  def move_to!(new_row, new_column)
    @pieces = Game.find(game_id).pieces
    @pieces.each do |piece|
      if piece.position_row == new_row && piece.position_column == new_column
        if piece.color == color
          #We can't move to a place where our own pieces are!
          puts "ERROR"
        else
          #Setting to nil to indicate a piece has been captured
          piece.position_row = nil
          piece.position_column = nil
        end
      end
    end
  end

end
