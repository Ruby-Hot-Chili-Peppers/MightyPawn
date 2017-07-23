class Game < ApplicationRecord

  scope :available, -> { where(black_player_id: nil) }

  belongs_to :white_player, class_name: "User", foreign_key:"white_player_id", required: false
  belongs_to :black_player, class_name: "User", foreign_key:"black_player_id", required: false

  has_many :pieces

  def set_pieces_on_board
    #white pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: white_player_id, position_row: 1, position_column: int, color: 'white', moves: 0)
    end

    King.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 4, color: 'white', moves: 0)
 
    Queen.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 3, color: 'white', moves: 0)
 
    Bishop.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 2, color: 'white', moves: 0)
 
    Bishop.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 5, color: 'white', moves: 0)
 
    Knight.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 1, color: 'white', moves: 0)
 
    Knight.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 6, color: 'white', moves: 0)
 
    Rook.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 0, color: 'white', moves: 0)
 
    Rook.create(game_id: id, user_id: white_player_id, position_row: 0, position_column: 7, color: 'white', moves: 0)

    
    #black pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: black_player_id, position_row: 6, position_column: int, color: 'black', moves: 0)
    end

    King.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 4, color: 'black', moves: 0)
 
    Queen.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 3, color: 'black', moves: 0)
 
    Bishop.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 2, color: 'black', moves: 0)
 
    Bishop.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 5, color: 'black', moves: 0)
 
    Knight.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 1, color: 'black', moves: 0)
 
    Knight.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 6, color: 'black', moves: 0)
 
    Rook.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 0, color: 'black', moves: 0)
 
    Rook.create(game_id: id, user_id: black_player_id, position_row: 7, position_column: 7, color: 'black', moves: 0)
  end 

  def set_default_turn
    update_attributes(turn: white_player_id)
  end

  def switch_player_turn
    turn == white_player_id ? self.turn = black_player_id : self.turn = white_player_id
  end

  def data_method
    pieces_hash = Hash.new {|hash, key| hash[key]={}}

    pieces.each do |piece|
      pieces_hash[piece.position_column][piece.position_row]= piece
    end 
    
    pieces_hash
  end
  
  #check if move puts opponent in check
  def check?

    white_king = King.find_by(color: 'white', game_id: id)
    black_king = King.find_by(color: 'black', game_id: id)
    white_pieces = Piece.where(color: 'white', game_id: id)
    black_pieces = Piece.where(color: 'black', game_id: id)

    #checks if a piece could move to the king spot
    black_pieces.each do | black_piece |
      if !black_piece.position_row.nil? && !black_piece.position_column.nil?
        if black_piece.valid_move?(white_king.position_row, white_king.position_column)  
         # puts black_piece.valid_move?(white_king.position_row, white_king.position_column) 
          return true
        end 
      end
    end
    
    white_pieces.each do |white_piece|
      if !white_piece.position_row.nil? && !white_piece.position_column.nil?
        if  white_piece.valid_move?(black_king.position_row, black_king.position_column)
          return true
        end
      end
    end

    return false  
  end

  #determines if a player is in checkmate and the game is over
  def checkmate?(king)
    #set the color of king 
    if king.color == 'black'
        color = 'white'
    else  
        color = 'black'
    end  
    #should not trigger if game is not in check
    return false unless check? 
    color_pieces = Piece.where(color: color, game_id: id)
    
    king_is_in_check_counter1 = 0
    king_is_in_check_counter2 = 0
    king_is_in_check_counter3 = 0
    king_is_in_check_counter4 = 0 
    king_is_in_check_counter5 = 0
    king_is_in_check_counter6 = 0 
    king_is_in_check_counter7 = 0
    king_is_in_check_counter8 = 0 
    
    #note below test the 9 cases if king is still in check and if all avenues for movement are blocked off it is in checkmate
    #test the case the king moves forward 1 row is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row+1,king.position_column)
          king_is_in_check_counter1 = king_is_in_check_counter1 + 1
          end  
      end  
    end  
    #test the case the king moves backward 1 row is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row-1,king.position_column)
          king_is_in_check_counter2 = king_is_in_check_counter2 + 1
          end  
      end  
    end 
    #test the case the king moves to the left 1 space is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row,king.position_column-1)
          king_is_in_check_counter3 = king_is_in_check_counter3 + 1
          end  
      end  
    end 
    #test the case the king moves to the right 1 space is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row,king.position_column+1)
          king_is_in_check_counter4 = king_is_in_check_counter4 + 1
          end  
      end  
    end 
    
    #test the case the king moves to the diagonal upper left  is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row+1,king.position_column-1)
          king_is_in_check_counter5 = king_is_in_check_counter5 + 1
          end  
      end  
    end 
    
    #test the case the king moves to the diagonal upper right  is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row+1,king.position_column+1)
          king_is_in_check_counter6 = king_is_in_check_counter6 + 1
          end  
      end  
    end 
    #test the case the king moves to the diagonal lower leftis it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row-1,king.position_column-1)
          king_is_in_check_counter7 = king_is_in_check_counter7 + 1
          end  
      end  
    end 
    
    #test the case the king moves to the diagonal lower right  is it still in check?
    color_pieces.each do |color_piece|
      if !color_piece.position_row.nil? && !color_piece.position_column.nil?
          if color_piece.valid_move?(king.position_row-1,king.position_column+1)
          king_is_in_check_counter8 = king_is_in_check_counter8 + 1
          end  
      end  
    end 
  

  if king_is_in_check_counter1 >= 1 && king_is_in_check_counter2 >= 1 && king_is_in_check_counter3 >= 1 && king_is_in_check_counter4 >= 1 &&king_is_in_check_counter5 >= 1 && king_is_in_check_counter6 >= 1 && king_is_in_check_counter7 >= 1 &&king_is_in_check_counter8 >= 1
    #not in checkmate  because in one instance the king could move and was not in check
    return true
  else
    #in all nine instance (assuming not on a border) the king could not move without being in check so therefore it is checkmate
    return false
  end  
    
  end
  
  #determines if game is in stalemate and no moves can be made
  def stalemate?
    
  end  


end
