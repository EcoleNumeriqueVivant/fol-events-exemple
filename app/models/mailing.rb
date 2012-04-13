#
# use MailChimp wrapper 
# take a look in /lib/MailChimp.rb
#
module Mailing
  extend ActiveSupport::Concern
  included do
       
    def subscribe
      unless self.email.nil? 
        MailChimp.subscribe self.email
      end
    end
    
    def unsubscribe
      unless self.email.nil? 
        MailChimp.unsubscribe self.email
      end
    end 
    
    # after_create :add_to_main_list
    # before_destroy :remove_from_main_list

    def add_to_main_list
      self.subscribe
    end
    
    def remove_from_main_list
      self.unsubscribe
    end
    
  end
end