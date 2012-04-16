class Event < ActiveRecord::Base
  
  include ActionView::Helpers::SanitizeHelper
  
  acts_as_taggable
  acts_as_taggable_on :typology, :theme
  
  attr_accessible :name, :desc, :tag_list
  
  include Addressable
  
  PUBLIC_URL = "http://fol-events.herokuapp.com/"
  
  def to_ics
    event = Icalendar::Event.new
    event.start = self.begin_date.strftime("%Y%m%dT%H%M%S")
    event.end = self.end_date.strftime("%Y%m%dT%H%M%S")
    event.summary = self.name
    event.description = "plus d\'information sur la fiche en ligne"
    event.location = "#{self.address.line1}\n#{self.address.zip}\n#{self.address.city}\n#{self.address.country}"
    event.klass = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}"
    event.add_comment("par Fontaine O Livres")
    event
  end
  
end
