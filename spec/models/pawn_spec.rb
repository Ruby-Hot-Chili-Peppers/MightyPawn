require 'rails_helper'

RSpec.describe Pawn, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @pawn1 = Pawn.first #(position (1,0), color: white)
    @pawn2 = Pawn.second #(position (1,1), color: white)
    @pawn3 = Pawn.last #(position: (6,7), color: black)
  end

  describe "Pawn's movement" do
    context 'no_move?' do 
      it 'returns true for no move' do
        expect(@pawn1.no_move?(1,0)).to be true
      end

      it 'returns false for move' do
        expect(@pawn1.no_move?(1,1)).to be false
      end
    end

    context 'is_obstructed?' do 
      it 'returns true if we are obstructed' do
        #put a pawn in the way
        @pawn2.update_attributes(position_row: 2, position_column: 0)
        expect(@pawn1.is_obstructed?(3,0)).to be true
      end

      it 'returns false if we are not obstructed' do
        #take the pawn out of the way
        @pawn2.update_attributes(position_row: 3, position_column: 2)
        expect(@pawn1.is_obstructed?(3,0)).to be false
      end
    end

     context 'valid_move?' do 
      it 'allows us to move 2 spaces forward if we have not moved before' do
        expect(@pawn1.valid_move?(3,0)).to be true
      end

      it 'does not allow us to move 2 spaces forward if we have already moved' do
        #update number of moves
        @pawn1.update_attributes(moves: @pawn1.moves + 1)
        expect(@pawn1.valid_move?(3,0)).to be false
      end

      it 'allows us to move diagonally to capture a piece of a different color' do
        #put pawn of opposing color in vertical position
        @pawn3.update_attributes(position_row: 2, position_column: 1)
        expect(@pawn1.valid_move?(2,1)).to be true
      end

      it 'does not accept bogus moves!' do
        expect(@pawn1.valid_move?(1,5)).to be false
      end
    end
  end
end