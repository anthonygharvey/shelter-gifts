class Shelter < ApplicationRecord
	belongs_to :user
	validates :name, :city, :state, :ein, :shelter_type, presence: true
	validates_format_of :ein, with: /\A^[1-9]\d?-\d{7}$\z|\A\d{9}\z/

end
