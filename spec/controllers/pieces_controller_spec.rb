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

        piece.reload
        piece2.reload
       
        #Pieces should be unaltered
        expect([piece.position_row, piece.position_column]).to eq [0,0]
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

      it "doesn't let a piece move if moving will put the king in check" do
        queen = Queen.find_by(color: "white")
        queen.update_attributes(position_row: 5, position_column: 6)
        pawn = Pawn.find_by(color: "black", position_column: 5) #currently @(6,5)

        #if the pawn moves, we are in check!
        patch :update, params: {id: pawn.id, y_coord: 5, x_coord: 5, moves: pawn.moves + 1}
        queen.reload
        pawn.reload

        #We shouldn't be able to move! 
        expect([queen.position_row, queen.position_column]).to eq [5,6]
        expect([pawn.position_row, pawn.position_column]).to eq [6,5]
      end
    end

    context "check?" do
      it "does not return an error message if a white piece puts the black king in check" do
        #put the white pawn in a location to capture the black king
        white_pawn = Pawn.where(color: "white").first
        white_pawn.update_attributes(position_row: 5, position_column: 3)
        black_pawn = Pawn.find_by(color: "black", position_column: 3)
        black_pawn.update_attributes(position_row: nil, position_column: nil)


        patch :update, params: {id: white_pawn.id, y_coord: 6, x_coord: 3, moves: white_pawn.moves + 1}
        white_pawn.reload

        expect(white_pawn.game.check?.first).to eq "black"
        expect([white_pawn.position_row, white_pawn.position_column]).to eq [6,3]
      end

      it "returns an error message if a whites move puts the white king in check" do
        #white pawn is currently keeping the white king out of check
        white_pawn = Pawn.find_by(color: "white", position_column: 3) #currently @(1,3)
        black_bishop = Bishop.where(color: "black").first
        black_bishop.update_attributes(position_row: 2, position_column: 2)

        patch :update, params: {id: white_pawn.id, y_coord: 2, x_coord: 3, moves: white_pawn.moves + 1}
        white_pawn.reload

        expect(response.status).to eq(405)

        expect(white_pawn.game.check?.first).to eq nil
        expect([white_pawn.position_row, white_pawn.position_column]).to eq [1,3]
      end

      it "does not return an error message if a black piece puts the white king in check" do
        #put the black pawn in a location to capture the white king
        black_pawn = Pawn.where(color: "black").first
        black_pawn.update_attributes(position_row: 2, position_column: 3)
        white_pawn = Pawn.find_by(color: "white", position_column: 3)
        white_pawn.update_attributes(position_row: nil, position_column: nil)

        patch :update, params: {id: black_pawn.id, y_coord: 1, x_coord: 3, moves: black_pawn.moves + 1}
        black_pawn.reload

 
        expect(black_pawn.game.check?.first).to eq "white"
        expect([black_pawn.position_row, black_pawn.position_column]).to eq [1,3]
      end

       it "returns an error message if a black piece puts the black king in check" do
        #white pawn is currently keeping the white king out of check
        black_pawn = Pawn.find_by(color: "black", position_column: 3) #currently @(6,3)
        white_bishop = Bishop.where(color: "white").first
        white_bishop.update_attributes(position_row: 5, position_column: 2)

        patch :update, params: {id: black_pawn.id, y_coord: 5, x_coord: 3, moves: black_pawn.moves + 1}
        black_pawn.reload

        expect(response.status).to eq(405)

        expect(black_pawn.game.check?.first).to eq nil
        expect([black_pawn.position_row, black_pawn.position_column]).to eq [6,3]
      end
    end
  end
end