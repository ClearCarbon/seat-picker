require 'spec_helper'

describe SeatsController do
  describe "GET #index" do
    it "when not logged in seats controller should respond with 302" do
      get :index
      expect(response.status).to eq(302)
    end
  end
end
