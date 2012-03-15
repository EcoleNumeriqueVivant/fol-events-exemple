class Event < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name, :desc, :tag_list
  include Addressable
end
