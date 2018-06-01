class User < ApplicationRecord
	has_secure_password
	validates :username, :first_name, presence: true
	validates_uniqueness_of :username
end
