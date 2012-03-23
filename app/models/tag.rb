class Tag < ActiveRecord::Base
  
  include Contextable 
  CONTEXTS = ["typology","theme"]
  add_scopes_for_contexts :context, CONTEXTS  
  
end
