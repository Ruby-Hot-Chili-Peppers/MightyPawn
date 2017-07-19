class PiecesController < ApplicationController  

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
      begin
        #will take piece off the board if captured, if not captured, this will do nothing
        @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i)
      rescue Exception => e
        #doesn't work
        return flash.notice =  e.message
      end
      #update the current pieces position
      if @piece.moves == nil
        @piece.moves = 0
      end
      @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
      #doesn't work
      flash[:success] = 'Updated!'
    else
      #doesn't work
      redirect_to game_path(@game), :flash => { :error => "Invalid move!" }
    end
  
  end
end
