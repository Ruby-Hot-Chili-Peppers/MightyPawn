require 'rails_helper'

RSpec.describe Pawn, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @pawn_black = Pawn.where(:position_row => 1, :position_column => 4, :game_id => 1).first
    @pawn_white = Pawn.where(:position_row => 6, :position_column => 4, :game_id => 1).first
  end

  describe "Pawn\'s movement" do
    context 'no_move?' do
      it 'returns true for no move' do
        expect(@pawn_black.no_move?(1,4)).to be true
        expect(@pawn_white.no_move?(6,4)).to be true
      end

      it 'returns false for no move' do
        expect(@pawn_black.no_move?(2,4)).to be false
        expect(@pawn_white.no_move?(5,4)).to be false
      end
    end

    context 'valid_move?' do
      it 'returns true for valid initial move' do
        #vertical-forward
        expect(@pawn_black.valid_move?(3,4)).to be true
        expect(@pawn_white.valid_move?(4,4)).to be true          
      end
      it 'returns true for valid move' do
        #vertical-forward
        expect(@pawn_black.valid_move?(2,4)).to be true
        expect(@pawn_white.valid_move?(5,4)).to be true
      end
      it 'returns false for invalid move' do
        #horizontal
        expect(@pawn_black.valid_move?(1,5)).to be false
        expect(@pawn_white.valid_move?(6,5)).to be false
        #vertical-backward
        expect(@pawn_black.valid_move?(2,4)).to be false
        expect(@pawn_white.valid_move?(5,4)).to be false
      end
    end
  end
end
  