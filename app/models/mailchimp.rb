# ;) chussenot
# more info about Struc here
# http://dev.af83.com/2012/02/20/ruby-structs.html
#
# This class warp Hominid & Gibbon gem
# API methods here
# http://apidocs.mailchimp.com/api/1.3/
#
class MailChimp < Struct.new(:lists)
    
  KEY           = "b07ec9d07287659537ec4389f0d2b2c0-us4" # customize key !
  MAIN_LIST     = "50c629afc5" # use MailChimp.lists['data'] to get lists id
  
  @@sts     = Hominid::STS.new(MailChimp::KEY, {:secure => true})
  @@export  = Hominid::Export.new(MailChimp::KEY, {:secure => true})
  
  @@gibbon =  Gibbon.new(MailChimp::KEY)
  
  class << self
    
    def run_hominid(attempts = 0, &block)
        attempts += 1
        block.call

      rescue EOFError => e
        if attempts < 3
          Rails.logger.error("Hominid EOFError, retrying: #{e.message}")
          run_hominid(attempts, &block)
        else
          Rails.logger.error("Give up on EOFError due to more than 3 attempts failed.")
        end
    end
    
    def get_hominid
        @h ||= Hominid::API.new(MailChimp::KEY, {:timeout => 60})
    end
    
    def gibbon_api
      @@gibbon
    end
    
    def sts
      @@sts
    end  
    
    def export
      @@export
    end  
    
    def account_details
      run_hominid do
        get_hominid.get_account_details
      end  
    end
    
    def lists
      run_hominid do 
         get_hominid.lists
      end
    end  
    
    def subscribe email
      run_hominid do
        get_hominid.list_subscribe(MAIN_LIST, email, {'FNAME' => 'xxx', 'LNAME' => 'public'}, 'html', false, true, true, false)
      end  
    end
    
    def unsubscribe email
      run_hominid do
        get_hominid.list_unsubscribe(MAIN_LIST, email)
      end
    end
    
    def add_template template_name, html_code
      run_hominid do
        get_hominid.template_add(template_name, html_code)
      end
    end
    
    def new(*keys)
         s = super
         s.class_eval do
           define_method(:initialize) do |hash|
             hash.each {|k,v| send("#{k}=",v) }
           end
         end
         # autoload here
         s.lists = MailChimp.lists
         s
    end
        
  end
       
end