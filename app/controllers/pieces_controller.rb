class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
  end

  def update
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
    @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord])
    redirect_to game_path(@game)
  end

end
