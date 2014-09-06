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
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  validates_uniqueness_of :email

  def name
    first_name + " " + last_name
  end

end
