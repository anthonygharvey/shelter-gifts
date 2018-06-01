require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User Factory" do
    it "has a valid user factory with a first_name, last_name, username, email and password" do
      expect(build(:user)).to be_valid
    end
  end

  describe "User Validations" do
    it "is invalid without a username" do
      expect(build(:user, username: nil)).not_to be_valid
    end

    it "requires a unique username" do
      create(:user, username: "rhendricks")
      user = build(:user, username: "rhendricks")
      user.valid?
      expect(user.errors.full_messages).to include("Username has already been taken")
    end

    it "requires a first_name" do
      expect(build(:user, first_name: nil)).not_to be_valid
    end
    
    it "requres a last_name" do
      expect(build(:user, last_name: nil)).not_to be_valid
    end
    
    it "is invalid without an email" do
      expect(build(:user, email: nil)).not_to be_valid
    end
    
    it "requires a unique email" do
      create(:user, email: 'richard.hendricks@piedpiper.com')
      user = build(:user, email: 'richard.hendricks@piedpiper.com')
      user.valid?
      expect(user.errors.full_messages).to include('Email has already been taken')
    end

    it "is invalid without a valid email (ex: user@gmail.com)" do
      expect(build(:user, email: 'bertram.gilfoyle@piedpiper..com')).not_to be_valid
    end

    it "is invalid without a password" do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it "is only valid when the password submitted is at least 6 characters long" do
      expect(build(:user, password: '123')).not_to be_valid
      expect(build(:user, password: '123456')).to be_valid
    end

    it "encrypts the password when saving" do
      user = create(:user, password: "testing123")
      expect(user.authenticate("testing123")).to eq(user)
      expect(user.authenticate("123testing")).not_to eq(user)
    end
  end

end
