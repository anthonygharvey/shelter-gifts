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
      user = expect(build(:user, last_name: nil))
      binding.pry
      expect(build(:user, last_name: nil)).not_to be_valid
    end
    
    it "is invalid without an email"

    it "requires a unique email"

    it "is invalid without a valid email (ex: user@gmail.com)"

    it "is invalid without a password"

    it "is only valid when the password submitted is at least 6 characters long"

    it "encrypts the password when saving"

  end

end
