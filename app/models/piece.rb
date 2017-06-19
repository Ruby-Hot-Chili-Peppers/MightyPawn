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
