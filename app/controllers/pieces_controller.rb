class PiecesController < ApplicationController  

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i) && !@piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i) 
      #Are we moving ourselves into check? If so, raise an error
      #if @piece.moving_into_check?(params[:y_coord].to_i, params[:x_coord].to_i) 
      #  flash[:error] = "You can't put your king in check!"
      #end 

      #This calls the capture logic to capture a piece if a piece is on the desired position
      begin
        @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i)
      rescue Exception => e
        #If we try to capture our own piece....
        return flash.notice =  e.message
      end

      #If everything works we update the current piece's position
      @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
      flash[:success] = 'Updated!'
    else
      redirect_to game_path(@game), :flash => { :error => "Invalid move!" }
    end
  
  end
end
