#
# using polymorphism for address
# http://kconrails.com/2010/10/19/common-addresses-using-polymorphism-and-nested-attributes-in-rails/
# use a module instead (see /lib/addresable.rb)
#
class Address < ActiveRecord::Base
  
  belongs_to :addressable, :polymorphic => true
  geocoded_by :address
  after_validation :geocode
  
  def address
    [line1, line2, city, state, country, zip].compact.join(', ')
  end
  
  # acts_as_gmappable
  # def gmaps4rails_address
  # #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  #   "#{self.street}, #{self.city}, #{self.country}" 
  # end
  
end
