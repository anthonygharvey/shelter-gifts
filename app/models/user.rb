class User < ApplicationRecord
	has_secure_password
	validates :username, :first_name, :last_name, :email, presence: true
	validates_uniqueness_of :username, :email
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :password, length: { minimum: 6 }
end
