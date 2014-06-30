require 'machinist/active_record'
require_relative '../blueprints'

module LoginHelper

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in User.make!(:admin)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.make!
      sign_in user
    end
  end
end

