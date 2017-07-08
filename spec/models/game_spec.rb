require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @bishop1 = Bishop.first #(position (0,2), color: white)
    @bishop2 = Bishop.second #(position (0,5), color: white)
    @bishop3 = Bishop.last #(position: (7,5), color: black)
    @pawn1 = Pawn.first #(position (1,0), color: white)
    @rook3 = Rook.last #(position: (7,7), color: black)
  end

  describe "Check method working" do
    context 'make sure check is false when the game starts' do 
      it 'returns false for starting board position' do
        expect(@game.check?).to be false
      end

      it 'returns true for king being in check if rook is in front of the king ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @rook3.update_attributes(position_row: 1, position_column: 4, moves: 1)
        expect(@game.check?).to be true 
      end   
      
       it 'returns true for king being in check with pawns removed from row' do
        #remove pawns to check that king is not in check since no piece can get there in one mover
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 0) 
        expect(@game.check?).to be false 
      end 
      
        it 'remove all pieces on the board except 2 kings (in there starting position), game should not be in check' do
        #remove pawns to check that king is not in check since no piece can get there in one mover
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Bishop.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Rook.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Queen.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Knight.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        expect(@game.check?).to be false 
      end 
      

    end
  end
end