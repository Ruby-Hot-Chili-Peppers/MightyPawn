require 'rails_helper'

RSpec.describe Knight, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
    @knight = Knight.first #white Knight @ position_row: 0, position_column: 1
    p @knight
  end

  describe "Knight\'s movement" do
      context 'no_move?' do 
        it 'returns true for no move' do
        end

        it 'returns false for move' do
        end
      end

      context 'proper_length?' do 
        it 'returns true for one space' do 
        end

        it 'returns false for more than one space' do

        end
      end

      context 'valid_move?' do 
        it 'returns true for valid move' do
        end

        it 'returns false for invalid move' do
        end
      end
  end

end