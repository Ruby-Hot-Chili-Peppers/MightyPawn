class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
  end

  def update
    #begin
      @piece = Piece.find(params[:id])
      @game = Game.find(@piece.game_id)
      puts " "
      puts " y coordinate type"
      p params[:y_coord]
      p params[:y_coord].to_i
      p @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
      puts @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
      puts " "
      #puts Piece.find(position_row: params[:y_coord], position_column: params[:x_coord], game_id: game_id)
      puts " "
      if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
        @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
        redirect_to game_path(@game)
      else
        raise RuntimeError, "invalid input. Not diagonal, horizontal, or vertical."
        #raise ActionController::RoutingError.new("Invalid move for piece due to obstruction, out of bounds or not correct. Please try another position.")
      end
    #rescue StandardError => e
      #flash.now[:alert] = "Invalid move for piece due to obstruction, out of bounds or not correct. Please try another position."
      #render "show"
    #end
  end

end
