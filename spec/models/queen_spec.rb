require 'rails_helper'

RSpec.describe Queen, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @queen1 = Queen.first  #(position (0,3), color: black)
    @queen2 = Queen.second #(position (7,3), color: white)
    
  end

  describe "Queens's movement" do
    context 'no_move?' do 
      it 'returns true for no move' do
        expect(@queen1.no_move?(0,3)).to be true
      end

      it 'returns false for move' do
        #clear the pawns so the queen can move
        Pawn.all.update_all(position_row: nil, position_column: nil)      
        expect(@queen1.no_move?(1,4)).to be false
      end
    end

    context 'is_obstructed?' do 
      it 'returns true if we are obstructed' do
        #since queen1 is blocked by a pawn expect to be obsstructed.
        Pawn.all.update_all(position_row: 1, position_column: 3)  
        expect(@queen1.is_obstructed?(3,3)).to be true
      end

      it 'returns false if we are not obstructed' do
        #clear the pawns so the queen can move
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@queen1.is_obstructed?(3,3)).to be false
      end
    end

     context 'valid_move?' do 
      it 'allows us to move row if not obstructed' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@queen1.valid_move?(3,3)).to be true
      end
      
      it 'allows us to move daigonal forward if not obstructed' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@queen1.valid_move?(3,0)).to be true
      end
      
      it 'allows us to move on a row  if not obstructed' do
        @queen1.update_attributes(position_row: 3, position_column: 0)
        expect(@queen1.valid_move?(3,6)).to be true
      end
      
      
      it 'allows us to move daigonal forward if not obstructed' do
        Pawn.all.update_all(position_row: nil, position_column: nil)
        expect(@queen1.valid_move?(4,7)).to be true
      end



    end
  end
end