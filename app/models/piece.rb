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

end
