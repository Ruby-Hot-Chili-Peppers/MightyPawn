class StaticController < ApplicationController
  def index
    @available = Game.available
  end
end
