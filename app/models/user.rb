class User < ActiveRecord::Base
  has_many :rounds

  validates_presence_of :username, :message => "Literally, you only need to enter two things, try again."

  include BCrypt

  	def authenticate(plaintext_password)
    	return true if BCrypt::Password.new(self.password_hash) == plaintext_password
  	end

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
	    @password = Password.create(new_password)
	    self.password_hash = @password
	end
end
