class Knight < Piece
  def symbol
    game.white_player_id == user_id ? '&#9816;' : '&#9822;'  
  end
end 