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
end
