require 'rails_helper'

RSpec.describe Shelter, type: :model do
  
  describe "Shelter Factory" do
    it "has a valid shelter factory with user_id, name, city, state, EIN, shelter_type, description and website_url" do
      expect(build(:shelter)).to be_valid
    end
  end

end
