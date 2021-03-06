require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @user = build(:user)
    @shelter = build(:shelter, user: @user)
    @list = build(:list, shelter: @shelter)
    @item = build(:item, list: @list)
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

    it "is invalid without a valid 'Add to Cart' or 'See all buying options' button" do
      expect(build(:item, list: @list, button_text: nil, button_url: 'https://www.amazon.com')).not_to be_valid
      expect(build(:item, list: @list, button_text: 'See all buying options', button_url: nil)).not_to be_valid
    end

    it "is only valid with a valid Amazon URL" do
      expect(build(:item, list: @list, url: "https://amazon.com/awesome_ruby_on_rails_book")).to be_valid
      expect(build(:item, list: @list, url: "https://nozama.com/awesome_ruby_on_rails_book")).not_to be_valid
    end
  end

  describe "Item Associations" do
    it { belong_to :list }
  end

  describe "Item Instance Methods" do
    describe "#to_cents" do
      it "returns the equivalent item price in cents" do
        expect(@item.to_cents).to eq((@item.price * 100).to_i)
      end
    end
    
    describe "#quantity_remaining" do
      it "returns the number of items needed to be gifted until the quantity requested is fulfilled" do
        expect(@item.quantity_remaining).to eq(@item.quantity - @item.has_amount)
      end
    end

    describe "#percent_gifted" do
      it "returns the percentage of items gifted to the quantity requested" do
        expect(@item.percent_gifted).to eq(@item.has_amount.to_f/@item.quantity.to_f)
      end
    end
  end

end
