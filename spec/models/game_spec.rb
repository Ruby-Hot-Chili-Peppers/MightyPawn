require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
  end

  describe "Setup" do
    it 'has 32 pieces' do
      piece_count = Piece.count
      game_count = Game.count
      #Game.last.pieces.each {|piece| p piece}
      expect(game_count).to eq 1
      expect(piece_count).to eq 32
    end

    it 'has 16 white pieces & 16 black pieces' do
      game_count = Game.count
      white_piece_count = Piece.where(:color => 'white').count
      black_piece_count = Piece.where(:color => 'black').count
      expect(game_count).to eq 1
      expect(white_piece_count).to eq 16
      expect(black_piece_count).to eq 16
    end

    it 'begins with white player\'s turn' do
      expect(@game.turn).to eq 1
    end
  end
end
