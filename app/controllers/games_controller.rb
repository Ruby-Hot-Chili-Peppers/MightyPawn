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
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(black_player_id: current_user.id)
    redirect_to game_path(@game)
  end

  private


end
