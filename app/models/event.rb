class Event < ActiveRecord::Base
  
  acts_as_taggable
  acts_as_taggable_on :typology, :theme
  
  attr_accessible :name, :desc, :tag_list
  
  include Addressable
end
