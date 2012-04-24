#
# publication module
#
module Publishable
  extend ActiveSupport::Concern
  
  include Stateable
  
  # publication status
  DRAFT           = "draft"
  REVIEW          = "review"
  ONLINE          = "online"
  ARCHIVED        = "archived"
  PUBLICATION_STATES = [DRAFT, REVIEW, ONLINE, ARCHIVED ]

  included do
    # Define publication scopes
    add_scopes_for_states :publish_state, PUBLICATION_STATES
    # Define boolean pulbication properties to test a state
    PUBLICATION_STATES.each do |s|
      define_method("#{s}?") do
        self.publish_state == s
      end
    end

    after_initialize :init_publication_status
    def init_publication_status
      #will set the default value only if it's nil
      self.publish_state  ||= DRAFT
      #self.save
    end 
  end
  
end