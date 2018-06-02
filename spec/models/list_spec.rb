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


end
