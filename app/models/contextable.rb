module Contextable
  extend ActiveSupport::Concern
  included do
    
    class << self      
      def add_scopes_for_contexts column, contexts
        # add a state scopes
        validates_inclusion_of column, :in => contexts, :message => "^invalid context"
        # Define a named scope for each kind in column
        contexts.each { |s| scope s, :conditions => { column => s } }
      end
    end
    
  end
end