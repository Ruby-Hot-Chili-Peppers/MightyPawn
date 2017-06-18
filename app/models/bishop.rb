class Bishop < Piece
  def symbol
    game.white_player_id == user_id ? '&#9815;' : '&#9821;'  
  end
end