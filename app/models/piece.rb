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
      elsif piece.position_row == new_row && piece.position_column == new_column 
        raise RuntimeError, "You can't capture your own piece!!!"
      end
    end
  end

  def moving_into_check?(new_row, new_column)
    #We will switch to the new coordinates temporarily and see if we are in check!
    current_row = self.position_row
    current_column = self.position_column
    self.update_attributes(position_row: new_row, position_column: new_column)
    status = self.check?
    self.update_attributes(position_row: current_row, position_column: current_column)
    return true if status == self.color

    #define my king and all the pieces from the other team
    #if self.color == "white"
    #  my_king = King.find_by(color: "white", game_id: game_id)
    #  opposing_pieces = Piece.where(color: "black", game_id: game_id)
    #else
    #  my_king = King.find_by(color: "black", game_id: game_id)
    #  opposing_pieces = Piece.where(color: "white", game_id: game_id)
    #end

    #borrowing this function from check? method
    #opposing_pieces.each do | piece |
    #  if !piece.position_row.nil? && !piece.position_column.nil?
    #    if piece.valid_move?(my_king.position_row, my_king.position_column) 
    #     #We don't want to update attribtues here as it will be done in the controller, so we revert back
    #      self.update_attributes(position_row: current_row, position_column: current_column)
    #      return true
    #    end 
    #  end
    #end
    #We don't want to update attribtues here as it will be done in the controller, so we revert back
    #self.update_attributes(position_row: current_row, position_column: current_column)
    return false
  end  


end
