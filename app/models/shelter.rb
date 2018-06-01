class Shelter < ApplicationRecord
	belongs_to :user
	validates :name, :city, :state, :ein, :shelter_type, presence: true
end
