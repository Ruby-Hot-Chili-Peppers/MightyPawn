class PiecesController < ApplicationController  

  def update
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
    @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
    render plain: 'updated!'
  end
end
