require 'spec_helper'

describe User do
  before :each do
    @user = User.new({"email" => "test@example.com", 
                      "username" => "test",
                      "password" => "password",
                      "password_confirmation" => "password" })
  end

  describe "#new" do
    it "sanity checks user creation" do
      @user.should be_an_instance_of User
      expect(@user.email).to eq("test@example.com")
    end
  end

  describe "#promote_to_admin!" do
    it "checks user can be promoted to admin" do
      expect(@user.admin?).to eq(false)
      @user.promote_to_admin!
      expect(@user.admin?).to eq(true)
    end
  end

  describe "#promote_to_admin!" do
    it "checks user can be demoted from admin" do
      expect(@user.admin?).to eq(false)
      @user.promote_to_admin!
      expect(@user.admin?).to eq(true)
      @user.demote_from_admin!
      expect(@user.admin?).to eq(false)
    end
  end
end
