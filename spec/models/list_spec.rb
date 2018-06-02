require 'rails_helper'

RSpec.describe List, type: :model do
  
  before(:each) do
    @user = build(:user)
    @shelter = build(:shelter, user: @user)
  end

  describe "List Factory" do
    it "has a valid list factory with a name, description and url" do
      expect(build(:list, shelter: @shelter)).to be_valid
    end
  end

  describe "List Validations" do
    it "is invalid without a name" do
      expect(build(:list, shelter: @shelter, name: nil)).not_to be_valid
    end

    it "is valid without a description" do
      expect(build(:list, shelter: @shelter, description: nil)).to be_valid
    end

    it "is invalid without a url" do
      expect(build(:list, shelter: @shelter, url: nil)).not_to be_valid
    end

    it "is only valid with a valid Amazon wishlist URL" do
      expect(build(:list, shelter: @shelter, url: "https://www.wrongurl.com")).not_to be_valid
      expect(build(:list, shelter: @shelter, url: "https://www.amazon.com/gp/registry/wishlist/123456789")).to be_valid
      expect(build(:list, shelter: @shelter, url: "https://www.amazon.com/gp/registry/wishlist/ABC123")).to be_valid
      expect(build(:list, shelter: @shelter, url: "https://www.amazon.com/gp/registry/wishlist/")).to be_valid
    end


  end


end
