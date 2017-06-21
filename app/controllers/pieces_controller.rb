class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
  end

  def update
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
    @piece.update_attributes(position_row: @piece.position_row, position_column: @piece.position_column)
    redirect_to game_path(@game)
  end

end
