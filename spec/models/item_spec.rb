require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @user = build(:user)
    @shelter = build(:shelter, user: @user)
    @list = build(:list, shelter: @shelter)
  end

  describe "Item Factory" do
    it "has a valid item factory with a name, price, photo, prime_status, comment, quantity, priority, has_amount and url" do
      expect(build(:item, list: @list)).to be_valid
    end
  end
end
