require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @bishop1 = Bishop.first #(position (0,2), color: white)
    @bishop2 = Bishop.second #(position (0,5), color: white)
    @bishop3 = Bishop.last #(position: (7,5), color: black)
    @pawn_white = Pawn.first #(position (1,0), color: white)
    @rook3 = Rook.last #(position: (7,7), color: black)
    @queen_black = Queen.last 
    @queen_white = Queen.first
    @knight = Knight.last
    @king_black = King.last
    @king_white = King.first
    @pawn_black = Pawn.last
    
  end

  describe "Checkmate method working" do
    context 'make sure checkmate is false when the game starts' do 
      it 'returns false for starting board position' do
        expect(@game.checkmate?(@king_black)).to be false
      end

      it 'returns false for king being in check by a knight, but is not in checkmate is false  ' do
        #knight puts king in check but not checkmate not other pieces around checking if can tell it is not check mate
        @knight.update_attributes(position_row: 1, position_column: 2)
        @knight.reload
        expect(@game.checkmate?(@king_white)).to be false
      end   
      

     it 'returns true if king cannot move without being in check? ' do
        #put king in checkmate? to make sure the logic work
        @king_black.update_attributes(position_row: 4, position_column: 2)
        @queen_white.update_attributes(position_row: 4, position_column: 7)
        Rook.first.update_attributes(position_row: 3, position_column: 0)
        Rook.second.update_attributes(position_row: 5, position_column: 0)
        @king_black.reload
        expect(@game.checkmate?(@king_black)).to be true
      end 
  



    end
  end
end