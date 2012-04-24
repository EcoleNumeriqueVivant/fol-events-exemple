module Stateable
  extend ActiveSupport::Concern
  included do
    
    class << self
      # add a meta definition method in stateable module
      # TODO move this to a meta module ?
      
      # exemple :
      # > Page.meta_def "foo" do
      # >     "bar"
      # > end
      # => #<Proc:0x007fe249b76b90@(irb):2 (lambda)> 
      # > Page.foo
      # => "bar"
          
      def meta_def name, &blk
          (class << self; self; end).instance_eval { define_method name, &blk }
      end
      
      def add_scopes_for_states column, states
        # add a state scopes
        validates_inclusion_of column, :in => states, :message => "^invalid state"
        # Define a named scope for each state in column
        states.each { |s| scope s, :conditions => { column => s } }
      end    
    end 
  end
end