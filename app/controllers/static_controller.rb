class StaticController < ApplicationController
  def index
    @available = Game.available
    @current = Game.all
  end
end
