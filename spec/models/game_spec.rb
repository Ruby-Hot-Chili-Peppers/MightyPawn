require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has 32 pieces' do
    game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    piece_count = Piece.count
    game_count = Game.count
    #Game.last.pieces.each {|piece| p piece}
    expect(game_count).to eq 1
    expect(piece_count).to eq 32
  end

  it 'has 16 white pieces & 16 black pieces' do
    game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    game_count = Game.count
    white_piece_count = Piece.where(:color => 'white').count
    black_piece_count = Piece.where(:color => 'black').count
    expect(game_count).to eq 1
    expect(white_piece_count).to eq 16
    expect(black_piece_count).to eq 16
  end


  describe "game pieces method is_Obstructed?" do
    it 'returns false to move horizontally if obstruction exists' do
      game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 3 ).first

      check = pawn.is_obstructed?(1,0) #go left
      check2 = pawn.is_obstructed?(1,7) #go right
      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns false to move vertically if obstruction exists' do
      game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,7) #go up
      check2 = pawn2.is_obstructed?(0,7) #go down

      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns false to move diagonally if obstruction exists' do
      game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,0) #bottom right corner to top left corner
      check2 = pawn2.is_obstructed?(0,0) #top right corner to bottom left corner
      expect(check).to be false
      expect(check2).to be false
    end

    it 'raises an error if invalid input' do
      game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first

      expect{ check = pawn.is_obstructed?(1,2) }.to raise_error(RuntimeError)
    end
  end
end
