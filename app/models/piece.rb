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

    def array_up(init, final)
      array = (init...final).to_a
      array = array[1,array.length]
    end

    def array_down(init, final)
      array = init.downto(final).to_a
      array = array[1, array.length-2]
    end

    #horizonal case
    if row_init == row_final
      if col_init <= col_final #going right
        col_rng = array_up(col_init, col_final)
      else #going left
        col_rng = array_down(col_init, col_final)
      end
      return !Piece.exists?(position_row: row_init, position_column: col_rng)

      #vertical case
    elsif col_init == col_final 
      if row_init <= row_final #going up
        row_rng = array_up(row_init, row_final)
      else #going down
        row_rng = array_down(row_init, row_final)
      end
      return !Piece.exists?(position_row: row_rng, position_column: col_init)

      #diagonal case
    elsif ((row_final - row_init).to_f/(col_final - col_init).to_f ).abs == 1
      if row_init <= row_final #going up
        row_rng = array_up(row_init, row_final)
      else #going down
        row_rng = array_down(row_init, row_final)
      end

      if col_init <= col_final #going right
        col_rng = array_up(col_init, col_final)
      else  #going left
        col_rng = array_down(col_init, col_final)
      end

      return !Piece.exists?(position_row: row_rng, position_column: col_rng)
    
      #invalid input case
    else
      raise RuntimeError, "invalid input. Not diagnal, horizontal, or vertical."
    end
  end
end
