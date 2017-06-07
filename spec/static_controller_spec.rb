require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  describe "static#index"  do
    it "should display the index page" do
      get :index
      expect(response).to have_http_status :success
    end 
  end
end