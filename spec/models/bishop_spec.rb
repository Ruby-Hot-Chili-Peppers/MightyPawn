require 'rails_helper'

RSpec.describe Bishop, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @bishop1 = Bishop.first #(position (0,2), color: black)
    @bishop2 = Bishop.second #(position (0,5), color: black)
    @bishop3 = Bishop.last #(position: (7,5), color: white)
  end

  describe "Bishop's movement" do
    context 'no_move?' do 
      it 'returns true for no move' do
        expect(@bishop1.no_move?(0,2)).to be true
      end

      it 'returns false for move' do
        #clear the pawns so the bishop can move
        Pawn.all.update_all(position_row: nil, position_column: nil)      
        expect(@bishop1.no_move?(1,1)).to be false
      end
    end

    context 'is_obstructed?' do 
      it 'returns true if we are obstructed' do
        #since bishop3 is blocked by a pawn expect to be obsstructed.
        Pawn.all.update_all(position_row: 6, position_column: 4)  
        expect(@bishop3.is_obstructed?(2,0)).to be true
      end

      it 'returns false if we are not obstructed' do
        #clear the pawns so the bishop can move
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@bishop1.is_obstructed?(1,1)).to be false
      end
    end

     context 'valid_move?' do 
      it 'allows us to move  forward if not obstructed' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@bishop1.valid_move?(4,6)).to be true
      end

      it 'does not allow moving unless straight column or row' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        #moving rook like bishop checking if valid
        expect(@bishop1.valid_move?(0,1)).to be false
      end


    end
  end
end