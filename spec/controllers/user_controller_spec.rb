require 'spec_helper'
require_relative '../blueprints'

describe UsersController do
  describe "GET #edit" do
    it "should respond with an edit page" do
      login_user
      get :edit
      expect(response.status).to eq(200)
      expect(response).to render_template("edit")
    end
  end
end
