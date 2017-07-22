class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(white_player_id: current_user.id)
    @game.set_pieces_on_board
    @game.set_default_turn
    #redirect_to game_path(@game)
    #broadcast to channel when game is created
    if @game.save
      ActionCable.server.broadcast 'games'
        games: @game.pieces
        users: @game.users.email
        head :ok
    end
  end

  def update
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game.id, color: "black")
    @game.update_attributes(black_player_id: current_user.id)
    @pieces.update_all(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  private


end
