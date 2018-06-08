require 'rails_helper'

RSpec.describe List, type: :model do
  
  before(:each) do
    @user = build(:user)
    @shelter = build(:shelter, user: @user)
    @list = build(:list, shelter: @shelter)
    @item1 = create(:item, list: @list, price: 12.58, prime_status: true, priority:"Highest")
    @item2 = create(:item, list: @list, price: 25.41, prime_status: true, priority:"Highest")
    @item3 = create(:item, list: @list, price: 13.65, prime_status: true, priority:"High")
    @item4 = create(:item, list: @list, price: 42.81, prime_status: true, priority:"Medium")
    @item5 = create(:item, list: @list, price: 32.18, prime_status: true, priority:"Medium")
    @item6 = create(:item, list: @list, price: 65.12, priority:"Low")
    @item7 = create(:item, list: @list, price: 18.95, priority:"Low")
    @item8 = create(:item, list: @list, price: 12.53, priority:"Lowest")
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

  describe "List Associations" do
    it { should belong_to :shelter }
    it { should have_many :items }
  end

  describe "List Instance Methods" do
    describe "#items_by_priority" do
      it "returns a collection of items based on priority" do
        expect(@list.items_by_priority("Highest")).to contain_exactly(@item1, @item2)        
        expect(@list.items_by_priority("medium")).to contain_exactly(@item4, @item5)        
      end
    end

    describe "#items_by_prime_status" do
      it "returns a collection of items based on prime_status" do
        expect(@list.items_by_prime_status(true)).equal?([@item1, @item2, @item3, @item4])
        expect(@list.items_by_prime_status(false)).equal?([@item5, @item6, @item7, @item8])
      end
    end
    
    describe "items_by_price_range" do
      it "returns a collection of items with prices that fall within the specified range" do
        expect(@list.items_by_price_range("10.00", "25.00")).to contain_exactly(@item1, @item3, @item7, @item8)
        expect(@list.items_by_price_range("30.00", "50.00")).to contain_exactly(@item4, @item5)
        expect(@list.items_by_price_range("100.00", "200.00")).to contain_exactly()
      end
    end

    describe "get_items" do
      it "returns a collection of valid Item objects" do
        @list.url = "https://www.amazon.com/hz/wishlist/ls/Y5IV9G7N16QU?filter=DEFAULT&lek=d6dc71fd-3690-4470-a634-288964c6ec47&sort=default&type=wishlist"
        puts "Scrapping the website now...."
        expect(@list.get_items(@list.url)).all.to be_instance_of(Item)
      end
    end
  end

end
