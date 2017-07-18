class PiecesController < ApplicationController  

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i) && !@piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i) 
      #This calls the capture logic to capture a piece if a piece is on the desired position
      begin
        @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i)
      rescue Exception => e
        #If we try to capture our own piece....
        return flash.notice =  e.message
      end

      #If everything works we update the current piece's position
      @game.switch_player_turn
      @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
    else
      if !@piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
        error_message = "Invalid move"
      elsif @piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i)
        error_message = "Moving into check eh"
      end
      render :json => error_message, :status => :method_not_allowed
    end
  end
end
