class Shelter < ApplicationRecord
	belongs_to :user
	has_many :lists
	has_many :items, through: :lists
	validates :name, :city, :state, :ein, :shelter_type, presence: true
	validates_format_of :ein, with: /\A^[0-9]\d?-\d{7}$\z|\A\d{9}\z/
	validates_uniqueness_of :ein

	scope :by_state, 	-> state { where(state: state) if state.present? }
	scope :by_city, 	-> city { where(city: city) if city.present? }
	scope :by_type,		-> shelter_type { where(shelter_type: shelter_type) if shelter_type.present? }

	SHELTER_TYPES = ["Adult homeless", "Youth homeless", "Family homeless", "Religious", "Transitional housing/shelter program", "Government run", "Halfway house", "Wet shelter"]
end
