class Piece < ApplicationRecord
  belongs_to :game

  #checks if piece didn’t move
  def not_moved?
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
  def valid_move?
  return false if piece.not_moved?
  #add more checks
   
  end

  def is_obstructed?(row_final, col_final)
    row_init = self.position_row
    col_init = self.position_column

    #horizonal case
    if row_init == row_final
      if col_init <= col_final #going right
        col_rng = (col_init...col_final).to_a
        col_rng = col_rng[1, col_rng.length]
        return !Piece.exists?(position_row: row_init, position_column: col_rng)
      end
      
      if col_init > col_final #going left
        col_rng = col_init.downto(col_final).to_a
        col_rng = col_rng[1, col_rng.length-2]
        return !Piece.exists?(position_row: row_init, position_column: col_rng)
      end


    #vertical case
    elsif col_init == col_final 
      if row_init <= row_final #going up
        row_rng = (row_init...row_final).to_a
        row_rng = row_rng[1, row_rng.length]
        return !Piece.exists?(position_row: row_rng, position_column: col_init)
      end
      
      if row_init > row_final #going down
        row_rng = row_init.downto(row_final).to_a 
        row_rng = row_rng[1, row_rng.length-2]
        return !Piece.exists?(position_row: row_rng, position_column: col_init)
      end
    

    #diagonal case
    elsif ((row_final - row_init)/(col_final - col_init)).abs == 1
      if row_init <= row_final #going up
        row_rng = (row_init...row_final).to_a
        row_rng = row_rng[1, row_rng.length]
      else #going down
        row_rng = row_init.downto(row_final).to_a 
        row_rng = row_rng[1, row_rng.length-2]
      end

      if col_init <= col_final #going right
        col_rng = (col_init...col_final).to_a
        col_rng = col_rng[1, col_rng.length-2]
      else  #going left
        col_rng = col_init.downto(col_final).to_a
        col_rng = col_rng[1, col_rng.length-2]
      end
      #puts "test diagonally"
      #p row_rng
      #p col_rng
      #puts Piece.exists?(position_row: row_rng, position_column: col_rng)
      return !Piece.exists?(position_row: row_rng, position_column: col_rng)
    

    #invalid input case
    else
      puts "Testing this case does occur"
      raise RuntimeError, "invalid input. Not diagnal, horizontal, or vertical."
    end
  end
end
