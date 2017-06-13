class Pawn < Piece
  def symbol
    game.white_player_id == user_id ? '&#9817' : '&#9823'  
  end
end
