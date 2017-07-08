require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  before do
    @game = Game.create(id: 1, white_player_id: 1, black_player_id: 2)
    @game.set_pieces_on_board
    @game.set_default_turn
  end

  describe "pieces#update" do
    context "when valid_move? returns false" do
      it "responds with flash message & redirects to piece show page due to obstruction" do
        piece = Rook.first #white Rook @ position_row: 0, position_column: 0

        #based on how the links in the html show piece is setup, new parameters are used like so:
        #the position_row is y_coord: and position_column is x_coord
        patch :update, params: {id: piece.id, y_coord: 3, x_coord: 0, moves: piece.moves + 1}
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to piece_path(piece)
        expect([piece.position_row,piece.position_column]).to eq [0,0]
      end
    end

    context "when valid_move? returns true" do
      it "piece position is updated successfully & redirected to game show page" do
        piece = Pawn.first #white pawn @ position_row: 1, position_column: 0
   
        patch :update, params: {id: piece.id, y_coord: 3, x_coord: 0, moves: piece.moves + 1}

        piece.reload
        expect(response).to redirect_to game_path(@game)
        expect([piece.position_row,piece.position_column]).to eq [3,0]
      end
    end

    context "move_to!" do
      it "does not capture the piece if the desired position is occupied by the same color" do
        white_pawn1 = Pawn.second #located @ (1,1)
        #another piece of the same color exists in the position we want to move to
        white_pawn2 = Pawn.third #(located @(3,2)
        white_pawn2.update_attributes(position_row: 2, position_column: 1) 
        puts "first puts"
        p white_pawn2
        puts "second"
        p white_pawn1.valid_move?(2,1)
        #white_pawn1.move_to!(2,1)
        puts "third"
        p white_pawn2
        puts "fourth"
        p Pawn.third
        patch :update, params: {id: white_pawn1.id, y_coord: 2, x_coord: 1, moves: white_pawn1.moves + 1}
        puts " "
        white_pawn1.reload
        p white_pawn1

        expect{ patch :update, 
          params: {id: white_pawn1.id, y_coord: 2, x_coord: 1, moves: white_pawn1.moves + 1} }.to raise_error(RuntimeError)        
        #The piece in the desired position does not update its coordinates
        expect([white_pawn2.position_row, white_pawn2.position_column]).to eq [2,2]
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
  end
end