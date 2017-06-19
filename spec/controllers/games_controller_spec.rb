require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "game#create action" do

    it "should require users to be logged in" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end


    it "should successfully create a new game in our database" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create
      
      #expect(response).to redirect_to root_path
      game_count = Game.count
      piece_count = Piece.count
      p Game.last.pieces
      expect(game_count).to eq 1
      expect(piece_count).to eq 32
    end

  end

end
