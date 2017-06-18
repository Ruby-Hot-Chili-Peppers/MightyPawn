class Rook < Piece
  def symbol
    game.white_player_id == user_id ? '&#9814;' : '&#9820;'  
  end
end 