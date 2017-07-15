require 'rails_helper'

RSpec.describe Piece, type: :model do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
  end

  describe "method is_Obstructed?" do
    it 'returns true when move horizontally if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 3 ).first

      check = pawn.is_obstructed?(1,0) #go left
      check2 = pawn.is_obstructed?(1,7) #go right
      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move horizontally if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 3 ).first

      check = pawn.is_obstructed?(1,2) #go left
      check2 = pawn.is_obstructed?(1,4) #go right
      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns true when move vertically if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,7) #go up
      check2 = pawn2.is_obstructed?(0,7) #go down

      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move vertically if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 6, :position_column => 7 ).first

      check = pawn.is_obstructed?(5,7) #go up
      check2 = pawn2.is_obstructed?(2,7) #go down

      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns true when move diagonally if obstruction exists' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 7, :position_column => 7 ).first

      check = pawn.is_obstructed?(7,0) #bottom right corner to top left corner
      check2 = pawn2.is_obstructed?(0,0) #top right corner to bottom left corner
      expect(check).to be true
      expect(check2).to be true
    end

    it 'returns false when move diagonally if obstruction does not exist' do
      pawn = Piece.where(:color => 'white', :position_row => 1, :position_column => 6 ).first
      pawn2 = Piece.where(:color => 'black', :position_row => 6, :position_column => 6 ).first

      check = pawn.is_obstructed?(5,2) #bottom right corner to top left corner
      check2 = pawn2.is_obstructed?(2,2) #top right corner to bottom left corner
      expect(check).to be false
      expect(check2).to be false
    end

    it 'returns false with invalid input' do
      pawn = Piece.where(:color => 'white', :position_row => 0, :position_column => 7 ).first
      expect(pawn.is_obstructed?(1,2)).to eq false
    end
  end

  describe "move_to!" do
    it "does not capture the piece if the desired position is occupied by the same color" do
      white_pawn1 = Pawn.second #located @ (1,1)
      #another piece of the same color exists in the position we want to move to
      white_pawn2 = Pawn.third #(located @(1,2)

      expect{ white_pawn1.move_to!(1,2) }.to raise_error(RuntimeError)
      
      #The piece in the desired position does not update its coordinates
      expect([white_pawn2.position_row, white_pawn2.position_column]).to eq [1,2]
    end

    it "captures the opposing team piece if the desired position is occupied by opposing team" do
      #capture succeeds tnat that opponent piece has nil for position 
      white_pawn1 = Pawn.second #located @(1,1)
      black_pawn1 = Pawn.last #located @(6,7)

      white_pawn1.move_to!(6,7)

      black_pawn1.reload
      #the opposing piece should have its coordinates changed to nil, nil 
      expect([black_pawn1.position_row, black_pawn1.position_column]).to eq [nil,nil]
    end
  end

  describe "moving_into_check?" do
    it "returns true if moving your piece puts your king in check" do
      #Note the white king is #@position (0,4)
      pawn_white = Pawn.find_by(color: "white", position_column: 3) #@position (3,1)
      bishop_black = Bishop.where(color: "black").first #@position (7,2)
      
      #Setup the board such that the white pawn is preventing the bishop from taking the king
      bishop_black.update_attributes(position_row: 2, position_column: 2)

      #if the pawn tries to move, he will put the king in check!
      check = pawn_white.moving_into_check?(3, 2)
      expect(check).to be(true)
    end

    it "returns true if moving your piece puts your king in check" do
      #Now we call the same pawn, but we don't move the bishop such that it is in position to take the king
      pawn_white = Pawn.find_by(color: "white", position_column: 3) #@position (1, 3)
      
      #if the pawn tries to move, there should be no problem!
      check = pawn_white.moving_into_check?(3, 2)
      expect(check).to be(false)
    end
  end
end