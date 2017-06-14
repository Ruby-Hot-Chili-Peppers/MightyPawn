class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.create(white_player_id: current_user.id)
    #Need to refresh the page here
    redirect_to :back
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(black_player_id: current_user.id)
  end

end
