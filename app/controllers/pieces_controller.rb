class PiecesController < ApplicationController  

  def index
    @game = Game.find_by_id(params[:game_id])
    return render_not_found if @game.blank?
    render json: @game.pieces.order(:id)
  end

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    #If you are in check, you must move out of check if possible!
    if @piece.game.check?.first == @piece.color 
      #In this case, if you move out of check then moving_into_check will return false...we also need to add not in checkmate here, because if we are in checkmate, it will be impossible to move 
      if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i) && !@piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i) && #notCheckmate
        #This calls the capture logic to capture a piece if a piece is on the desired position
        if @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i) == false
          error_message = "You can't capture your own piece!"
          render :json => error_message, :status => :method_not_allowed
        else
          #If everything works we update the current piece's position
          @game.switch_player_turn
          @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
        end
      else
        if !@piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
          error_message = "Invalid move"
        elsif @piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i)
          error_message = "You must get out of check!"
        end
        render :json => error_message, :status => :method_not_allowed
      end
    elsif @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i) && !@piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i) 
      #This calls the capture logic to capture a piece if a piece is on the desired position
        if @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i) == false
          error_message = "You can't capture your own piece!"
          render :json => error_message, :status => :method_not_allowed
        else
          #If everything works we update the current piece's position and switch the turn
          @game.switch_player_turn
          @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
          
          #broadcast to channel when piece is updated
          ActionCable.server.broadcast 'pieces',
          type: @piece.type, 
          color: @piece.color, 
          row: @piece.position_row,
          column: @piece.position_column
          head :ok
          
        end
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
