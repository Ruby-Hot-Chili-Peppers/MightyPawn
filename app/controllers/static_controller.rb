class StaticController < ApplicationController
  def index
    @available = Game.available
    @current = Game.current
  end
end
