require 'rails_helper'

RSpec.describe Shelter, type: :model do

  before(:each) do
    @user1 = build(:user)
    @user2 = build(:user)
    @user3 = build(:user)
  end

  describe "Shelter Factory" do
    it "has a valid shelter factory with user_id, name, city, state, EIN, shelter_type, description and website_url" do
      expect(build(:shelter, user: @user1)).to be_valid
    end
  end

  describe "Shelter Validations" do
    it "is invalid without a name" do
      expect(build(:shelter, user: @user1, name: nil)).not_to be_valid
    end

    it "is invalid without a City" do
      expect(build(:shelter, user: @user1, city: nil)).not_to be_valid
    end

    it "is invalid without a State" do
      expect(build(:shelter, user: @user1, state: nil)).not_to be_valid
    end

    it "is invalid without an EIN" do
      expect(build(:shelter, user: @user1, ein: nil)).not_to be_valid
    end

    it "is valid with a valid EIN" do
      expect(build(:shelter, user: @user1, ein: "123456789")).to be_valid
      expect(build(:shelter, user: @user1, ein: "12-3456789")).to be_valid
      expect(build(:shelter, user: @user1, ein: "12345678")).not_to be_valid
      expect(build(:shelter, user: @user1, ein: "1234567890")).not_to be_valid
    end

    it "is invalid without a shelter type" do
      expect(build(:shelter, user: @user1, shelter_type: nil)).not_to be_valid
    end

    it "is valid without a description" do
      expect(build(:shelter, user: @user1, description: nil)).to be_valid
    end

    it "is valid without a website URL" do
      expect(build(:shelter, user: @user1, website_url: nil)).to be_valid
    end
  end
  
  describe "Shelter Associations" do
    it { should belong_to :user }
    it { should have_many :lists }
    it { should have_many(:items).through(:lists) }
  end

  describe "Shelter Scope Methods" do
    describe "by_state" do
      it "returns a collection of shelters in particular states by search" do
        shelter1 = create(:shelter, user: @user1, state: "North Carolina")
        shelter2 = create(:shelter, user: @user2, state: "North Carolina")
        shelter3 = create(:shelter, user: @user3, state: "Georgia")
        expect(Shelter.by_state("North Carolina")).to contain_exactly(shelter1, shelter2)
        expect(Shelter.by_state("North Carolina")).not_to include(shelter3)
        expect(Shelter.by_state("Florida")).to eq([])
      end
    end

    describe "by_city" do
      it "returns a collection of shelters only in a particular city by search" do
        shelter1 = create(:shelter, user: @user1, city: "Charlotte")
        shelter2 = create(:shelter, user: @user2, city: "Charlotte")
        shelter3 = create(:shelter, user: @user3, city: "Atlanta")
        expect(Shelter.by_city("Charlotte")).to contain_exactly(shelter1, shelter2)
        expect(Shelter.by_city("Charlotte")).not_to include(shelter3)
        expect(Shelter.by_city("Orlando")).to eq([])
      end
    end

    describe "by_type" do
      it "returns a collection of shelters only of a particular type by search" do
        shelter1 = create(:shelter, user: @user1, shelter_type: "Men's Shelter")
        shelter2 = create(:shelter, user: @user2, shelter_type: "Men's Shelter")
        shelter3 = create(:shelter, user: @user3, shelter_type: "Women & Children")
        expect(Shelter.by_type("Men's Shelter")).to contain_exactly(shelter1, shelter2)
        expect(Shelter.by_type("Women & Children")).not_to include(shelter1, shelter2)
      end
    end

  end
end

