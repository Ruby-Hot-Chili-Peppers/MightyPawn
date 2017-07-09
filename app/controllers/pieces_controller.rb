class PiecesController < ApplicationController  

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
      begin
        #will take piece off the board if captured, if not captured, this will do nothing
        @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i)
      rescue Exception => e
        return flash.notice =  e.message
      end
      #update the current pieces position
      @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
      render plain: 'updated!'
    else
      flash.notice =  "Invalid move for piece. Please try again."
    end
  
  end
end
