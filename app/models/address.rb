# coding: utf-8
# == Schema Information
#
# Table name: addresses
#
#  id               :integer         not null, primary key
#  line1            :string(255)     default("")
#  line2            :string(255)     default("")
#  city             :string(255)     default("")
#  state            :string(255)     default("")
#  country          :string(255)     default("")
#  zip              :string(255)     default("")
#  addressable_id   :integer
#  addressable_type :string(255)     default("")
#  latitude         :float
#  longitude        :float
#


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
  
  STATES_LIST = ["Pas de Région",
  "Alsace",
  "Aquitaine",
  "Auvergne",
  "Basse-Normandie",
  "Bourgogne",
  "Bretagne",
  "Centre",
  "Champagne-Ardenne",
  "Corse",
  "Franche-Comté",
  "Guadeloupe",
  "Guyane",
  "Haute-Normandie",
  "Île-de-France",
  "La Réunion",
  "Languedoc-Roussillon",
  "Limousin",
  "Lorraine",
  "Martinique",
  "Midi-Pyrénées",
  "Nord-Pas-de-Calais",
  "Pays de la Loire",
  "Picardie",
  "Poitou-Charentes",
  "Provence-Alpes-Côte d'Azur",
  "Rhône-Alpes"]
  
end
