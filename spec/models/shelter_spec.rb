require 'rails_helper'

RSpec.describe Shelter, type: :model do

  before(:each) do
    @user = build(:user)
  end

  describe "Shelter Factory" do
    it "has a valid shelter factory with user_id, name, city, state, EIN, shelter_type, description and website_url" do
      expect(build(:shelter, user: @user)).to be_valid
    end
  end

  describe "Shelter Validations" do
    it "is invalid without a name" do
      expect(build(:shelter, user: @user, name: nil)).not_to be_valid
    end

    it "is invalid without a City" do
      expect(build(:shelter, user: @user, city: nil)).not_to be_valid
    end

    it "is invalid without a State" do
      expect(build(:shelter, user: @user, state: nil)).not_to be_valid
    end

    it "is invalid without an EIN" do
      expect(build(:shelter, user: @user, ein: nil)).not_to be_valid
    end

    it "is valid with a valid EIN" do
      expect(build(:shelter, user: @user, ein: "123456789")).to be_valid
      expect(build(:shelter, user: @user, ein: "12-3456789")).to be_valid
      expect(build(:shelter, user: @user, ein: "12345678")).not_to be_valid
      expect(build(:shelter, user: @user, ein: "1234567890")).not_to be_valid
    end

    it "is invalid without a shelter type" do
      expect(build(:shelter, user: @user, shelter_type: nil)).not_to be_valid
    end

    it "is valid without a description" do
      expect(build(:shelter, user: @user, description: nil)).to be_valid
    end

    it "is valid without a website URL" do
      expect(build(:shelter, user: @user, website_url: nil)).to be_valid
    end
  end
  
  describe Shelter do
    it { should belong_to :user }
    it { should have_many :lists }
  end

end

