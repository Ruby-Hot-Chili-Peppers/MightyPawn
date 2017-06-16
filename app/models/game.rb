class Game < ApplicationRecord

  scope :available, -> { where(black_player_id: nil) }

  belongs_to :white_player, class_name: "User", foreign_key:"white_player_id", required: false
  belongs_to :black_player, class_name: "User", foreign_key:"black_player_id", required: false

  has_many :pieces 

  after_create :set_pieces_on_board
  after_create :set_default_turn

  def set_pieces_on_board
    #white pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: white_player_id, position_column:int, position_row: 1, color: 'white')
    end

    King.create(game_id: id, user_id: white_player_id, position_column: 4, position_row: 0, color: 'white')
 
    Queen.create(game_id: id, user_id: white_player_id, position_column: 3, position_row: 0, color: 'white')
 
    Bishop.create(game_id: id, user_id: white_player_id, position_column: 2, position_row: 0, color: 'white')
 
    Bishop.create(game_id: id, user_id: white_player_id, position_column: 5, position_row: 0, color: 'white')
 
    Knight.create(game_id: id, user_id: white_player_id, position_column: 1, position_row: 0, color: 'white')
 
    Knight.create(game_id: id, user_id: white_player_id, position_column: 6, position_row: 0, color: 'white')
 
    Rook.create(game_id: id, user_id: white_player_id, position_column: 0, position_row: 0, color: 'white')
 
    Rook.create(game_id: id, user_id: white_player_id, position_column: 7, position_row: 0, color: 'white')

    
    #black pieces
    (0..7).each do |int|
      Pawn.create(game_id: id, user_id: black_player_id, position_column:int, position_row: 6, color: 'black')
    end

    King.create(game_id: id, user_id: black_player_id, position_column: 4, position_row: 7, color: 'black')
 
    Queen.create(game_id: id, user_id: black_player_id, position_column: 3, position_row: 7, color: 'black')
 
    Bishop.create(game_id: id, user_id: black_player_id, position_column: 2, position_row: 7, color: 'black')
 
    Bishop.create(game_id: id, user_id: black_player_id, position_column: 5, position_row: 7, color: 'black')
 
    Knight.create(game_id: id, user_id: black_player_id, position_column: 1, position_row: 7, color: 'black')
 
    Knight.create(game_id: id, user_id: black_player_id, position_column: 6, position_row: 7, color: 'black')
 
    Rook.create(game_id: id, user_id: black_player_id, position_column: 0, position_row: 7, color: 'black')
 
    Rook.create(game_id: id, user_id: black_player_id, position_column: 7, position_row: 7, color: 'black')
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

end
