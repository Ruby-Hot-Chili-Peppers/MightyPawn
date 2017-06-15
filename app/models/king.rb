class King < Piece
  def symbol
    game.white_player_id == user_id ? '&#9812;' : '&#9818;'  
  end

end
