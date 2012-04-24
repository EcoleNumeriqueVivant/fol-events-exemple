# == Schema Information
#
# Table name: tags
#
#  id       :integer         not null, primary key
#  name     :string(255)
#  context  :string(255)
#  position :integer
#

class Tag < ActiveRecord::Base
  
  include Contextable 
  CONTEXTS = ["typology","theme"]
  add_scopes_for_contexts :context, CONTEXTS  
  
  acts_as_list # to manage position
  
  default_scope order(:position) 

end
