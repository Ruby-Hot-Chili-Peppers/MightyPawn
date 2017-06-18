class Queen < Piece
  def symbol
    game.white_player_id == user_id ? '&#9813;' : '&#9819;'  
  end
end 