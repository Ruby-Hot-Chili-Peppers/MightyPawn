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
        #expect(flash[:alert]).to be_present
        #expect(response).to redirect_to piece_path(piece)
        expect([piece.position_row,piece.position_column]).to eq [0,0]
      end
    end

    context "when valid_move? returns true" do
      it "piece position is updated successfully & redirected to game show page" do
        piece = Pawn.first #white pawn @ position_row: 1, position_column: 0
   
        patch :update, params: {id: piece.id, y_coord: 3, x_coord: 0, moves: piece.moves + 1}

        piece.reload
        #expect(response).to redirect_to game_path(@game)
        expect([piece.position_row,piece.position_column]).to eq [3,0]
      end
    end

    context "move_to!" do
      it "does not capture the piece if the desired position is occupied by the same color" do
        piece = Rook.first #white Rook @ position_row: 0, position_column: 0
        piece2 = Pawn.first #white pawn @ position_row: 1, position_column: 0

        patch :update, params: {id: piece.id, y_coord: 1, x_coord: 0, moves: piece.moves + 1}

        #expect(flash[:alert]).to be_present
        #expect(response).to redirect_to piece_path(piece)        
        #The piece in the desired position does not update its coordinates
        expect([piece2.position_row, piece2.position_column]).to eq [1,0]
      end

      it "captures the opposing team piece if the desired position is occupied by opposing team" do
        #capture succeeds tnat that opponent piece has nil for position 
        piece = Rook.first #white Rook @ position_row: 0, position_column: 0
        piece2 = Pawn.first #white pawn @ position_row: 1, position_column: 0
        piece2.update_attributes(color: "black") #change piece to black to test capture

        patch :update, params: {id: piece.id, y_coord: 1, x_coord: 0, moves: piece.moves + 1}

        piece2.reload
        #expect(response).to redirect_to game_path(@game)        
        #the opposing piece should have its coordinates changed to nil, nil 
        expect([piece2.position_row, piece2.position_column]).to eq [nil,nil]
      end
    end

  end
end