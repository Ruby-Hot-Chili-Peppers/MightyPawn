require 'rails_helper'

RSpec.describe Knight, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @knight = Knight.first #white Knight @ position_row: 0, position_column: 1
  end

  describe "\'s movement" do
      context 'no_move?' do 
        it 'returns true for no move' do
          expect(@knight.no_move?(0,1)).to be true
        end

        it 'returns false for move' do
          expect(@knight.no_move?(0,2)).to be false
        end
      end

      context 'out_of_boundary?' do 
        it 'returns true if out of bounds for new_row' do
          #2 down then left and out of bounds
          expect(@knight.out_of_boundary?(-2,0)).to be true
        end

        it 'returns true if out of bounds for new_column' do
          # reposition knight
          @knight.position_row = 0
          @knight.position_column = 0
          expect(@knight.out_of_boundary?(2,-1)).to be true
        end
      end

      context 'valid_move?' do 
        it 'returns true for L space vertical' do
          #2 up then left
          expect(@knight.valid_move?(2,0)).to be true
          #2 up then right
          expect(@knight.valid_move?(2,2)).to be true
          # reposition knight in order to test going down
          @knight.position_row = 2
          @knight.position_column = 2
          #2 down then left
          expect(@knight.valid_move?(0,1)).to be true
          #2 down then right
          expect(@knight.valid_move?(0,3)).to be true
        end

        it 'returns true for L space horizontal' do
          # reposition knight
          @knight.position_row = 2
          @knight.position_column = 2
          #2 right then up
          expect(@knight.valid_move?(3,4)).to be true
          #2 right then down
          expect(@knight.valid_move?(1,4)).to be true
          #2 left then up
          expect(@knight.valid_move?(3,0)).to be true
          #2 left then down
          expect(@knight.valid_move?(1,0)).to be true
        end

        it 'returns false if out of bounds for new_row' do
          #2 down then left and out of bounds
          expect(@knight.valid_move?(-2,0)).to be false
        end

        it 'returns false if out of bounds for new_column' do
          # reposition knight
          @knight.position_row = 0
          @knight.position_column = 0
          expect(@knight.valid_move?(2,-1)).to be false
        end

        it 'returns false for invalid move' do
          #horizontal 1 step
          expect(@knight.valid_move?(0,2)).to be false
          #vertical 1 step
          expect(@knight.valid_move?(1,1)).to be false
          #diagonal 1 step
          expect(@knight.valid_move?(1,2)).to be false
        end
      end
  end

end