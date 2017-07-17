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

  describe "Check method working" do
    context 'make sure check is false when the game starts' do 
      it 'returns false for starting board position' do
        expect(@game.check?.first).to be nil
      end

      it 'returns true for king being in check if knight  ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @knight.update_attributes(position_row: 1, position_column: 2)
        @knight.reload
        expect(@game.check?.first).to eq('white')
      end   
      
      it 'returns true for king being in check if king ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @king_black.update_attributes(position_row: 1, position_column: 4)
        @king_black.reload
        expect(@game.check?.first).to eq('white')
      end   
      
      it 'returns true for king being in check if bishop  ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @bishop3.update_attributes(position_row: 1, position_column: 3)
        @bishop3.reload
        expect(@game.check?.first).to eq('white')
      end 
      
      it 'returns true for king being in check if Rook ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @rook3.update_attributes(position_row: 1, position_column: 4)
        @rook3.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'returns true for king being in check if pawn ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @pawn_black.update_attributes(position_row: 3, position_column: 3, moves: 7)
        @pawn_black.reload
        King.first.update_attributes(position_row: 2, position_column: 4)
        expect(@game.check?.first).to eq('white')
      end
      
      it 'returns true for king being in check if queen ' do
        #put rook infront of king it should return true if the rook has valid move to the king 
        @queen_black.update_attributes(position_row: 1, position_column: 4)
        @queen_black.reload
        expect(@game.check?.first).to eq('white')
      end
      
       it 'returns true for king being in check with pawns removed from row' do
        #remove pawns to check that king is not in check since no piece can get there in one mover
        Pawn.all.update_all(position_row: nil, position_column: nil) 
        expect(@game.check?.first).to be nil
      end 
      
        it 'remove all pieces on the board except 2 kings (in there starting position), game should not be in check' do
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Bishop.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Rook.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Queen.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Knight.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        expect(@game.check?.first).to be nil 
      end 
      
      it 'white Queen casuing white king to not be in check' do
        @queen_white.update_attributes(position_row: 3, position_column: 1, moves: 7)  
        @pawn_black.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      
      it 'bug test white queen causing king to no be in check?' do
        @queen_white.update_attributes(position_row: 0, position_column: 3, moves: 7)  
        @pawn_black.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'bug test white queen causing king to no be in check?' do
        @queen_white.update_attributes(position_row: nil, position_column: nil, moves: 7)  
        @pawn_black.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Queen.all.update_all(position_row: nil, position_column: nil, moves: 8) 
        @pawn_black.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'bug test white queen causing king to no be in check?' do
        @queen_white.update_attributes(position_row: 5, position_column: 5, moves: 7)  
        @pawn_black.update_attributes(position_row: 1, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 0, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Pawn.all.update_all(position_row: nil, position_column: nil, moves: 1) 
        Queen.first.update_attributes(position_row: 1, position_column: 3, moves: 7)  
        @pawn_black.update_attributes(position_row: 2, position_column: 3, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 1, position_column: 4)
        @king_white.reload
        expect(@game.check?.first).to eq('white') 
      end
      
      it 'bug test white queen causing king to no be in check?' do
        Queen.first.update_attributes(position_row: 4, position_column: 1, moves: 7)  
        @pawn_black.update_attributes(position_row: 5, position_column: 1, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 4, position_column: 0)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end
      
      it 'bug test white queen on the space to left of the white king causing it to no be in check?' do
        
        Queen.first.update_attributes(position_row: 4, position_column: 0, moves: 7)  
        @pawn_black.update_attributes(position_row: 5, position_column: 0, moves: 7)
        @pawn_black.reload
        @king_white.update_attributes(position_row: 4, position_column: 1)
        @king_white.reload
        expect(@game.check?.first).to eq('white')
      end

    end
  end
end