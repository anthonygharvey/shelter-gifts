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

  describe "Item Validations" do
    it "is invalid without a name" do
      expect(build(:item, list: @list, name: nil)).not_to be_valid
    end

    it "is invalide without a price" do
      expect(build(:item, list: @list, price: nil)).not_to be_valid
    end

    it "is invalid without a photo" do
      expect(build(:item, list: @list, photo: nil)).not_to be_valid
    end

    it "is invalid without a prime_status" do
      expect(build(:item, list: @list, prime_status: nil)).not_to be_valid
    end

    it "is valid without a comment" do
      expect(build(:item, list: @list, comment: nil)).to be_valid
    end

    it "is invalid without a quantity" do
      expect(build(:item, list: @list, quantity: nil)).not_to be_valid
    end

    it "is valid without a priority" do
      expect(build(:item, list: @list, priority: nil)).to be_valid
    end

    it "is invalid without a has_amount" do
      expect(build(:item, list: @list, has_amount: nil)).not_to be_valid
    end

    it "is invalid without a URL" do
      expect(build(:item, list: @list, url: nil)).not_to be_valid
    end

    it "is only valid with a valid Amazon URL" do
      expect(build(:item, list: @list, url: "https://www.amazon.com/awesome_ruby_on_rails_book")).to be_valid
      expect(build(:item, list: @list, url: "https://www.nozama.com/awesome_ruby_on_rails_book")).not_to be_valid
    end
  end

  describe "Item associations" do
    it { belong_to :list }
  end

end
