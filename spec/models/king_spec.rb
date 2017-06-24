require 'rails_helper'

RSpec.describe King, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @king = King.first #white King @ position_row: 0, position_column: 4
    p @king
  end

  describe "King\'s movement" do
      context 'no_move?' do 
        it 'returns true for no move' do
          expect(@king.no_move?(0,4)).to be true
        end

        it 'returns false for move' do
          expect(@king.no_move?(1,4)).to be false
        end
      end

      context 'proper_length?' do 
        it 'returns true for one space' do
          #vertical
          expect(@king.proper_length?(1,4)).to be true
          #horizontal
          expect(@king.proper_length?(0,5)).to be true
          #diagonal
          expect(@king.proper_length?(1,5)).to be true
        end

        it 'returns false for more than one space' do
          #vertical
          expect(@king.proper_length?(2,4)).to be false
          #horizontal
          expect(@king.proper_length?(0,6)).to be false
          #diagonal
          expect(@king.proper_length?(2,6)).to be false
        end
      end

      context 'valid_move?' do 
        it 'returns true for valid move' do
          #vertical
          expect(@king.valid_move?(1,4)).to be true
          #horizontal
          expect(@king.valid_move?(0,3)).to be true
          #diagonal
          expect(@king.valid_move?(1,3)).to be true
        end

        it 'returns false for invalid move' do
          #still
          expect(@king.valid_move?(0,4)).to be false
          #vertical
          expect(@king.valid_move?(2,4)).to be false
          #horizontal
          expect(@king.valid_move?(0,2)).to be false
          #diagonal
          expect(@king.valid_move?(2,2)).to be false
        end
      end
  end

end