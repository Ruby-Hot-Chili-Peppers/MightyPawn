require 'rails_helper'

RSpec.describe Rook, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @rook1 = Rook.first #(position (0,0), color: black)
    @rook2 = Rook.second #(position (0,7), color: black)
    @rook3 = Rook.last #(position: (7,7), color: white)
  end

  describe "Rooks's movement" do
    context 'no_move?' do 
      it 'returns true for no move' do
        expect(@rook1.no_move?(0,0)).to be true
      end

      it 'returns false for move' do
        #clear the pawns so the rook can move
        Pawn.all.update_all(position_row: nil, position_column: nil)      
        expect(@rook1.no_move?(1,0)).to be false
      end
    end

    context 'is_obstructed?' do 
      it 'returns true if we are obstructed' do
        #since rook3 is blocked by a pawn expect to be obsstructed (cannot move from 7,7 to 0,7 since pawns are in the way)
        Pawn.all.update_all(position_row: 6, position_column: 7)  
        expect(@rook3.is_obstructed?(0,7)).to be true
      end

      it 'returns false if we are not obstructed' do
        #clear the pawns so the rook can move
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@rook1.is_obstructed?(3,0)).to be false
      end
    end

     context 'valid_move?' do 
      it 'allows us to move 4 spaces forward if not obstrcuted' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@rook1.valid_move?(4,0)).to be true
      end

      it 'does not allow moving unless straight column or row' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        #moving rook like bishop checking if valid
        expect(@rook1.valid_move?(1,1)).to be false
      end


  
    end
  end
end