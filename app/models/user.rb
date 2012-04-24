# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  first_name    :string(255)
#  last_name     :string(255)
#  phone         :string(255)
#

class User < ActiveRecord::Base
  
    attr_accessible :email, :password, :password_confirmation, :last_name, :first_name

    attr_accessor :password
    before_save :encrypt_password

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email
    validates_uniqueness_of :email

    def self.authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
    
    def name
      first_name + " " + last_name
    end  
    
end
