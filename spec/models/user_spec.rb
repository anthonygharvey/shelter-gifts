require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User Factory" do
    it "has a valid user factory with a first_name, last_name, username, email and password" do
      expect(build(:user)).to be_valid
    end
  end
  
end
