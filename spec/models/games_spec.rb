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
    it 'cannot allow a piece to move horizontally if obstruction exists' do
    end

    it 'cannot allow a piece to move vertically if obstruction exists' do
    end

    it 'cannot allow a piece to move diagonally if obstruction exists' do
    end

    it 'raise an error if invalid input' do
    end
  end
end
