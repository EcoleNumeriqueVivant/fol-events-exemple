# == Schema Information
#
# Table name: events
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  begin_date          :date
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#  subscibe_limit_date :date
#  end_date            :date
#  attendance          :string(255)
#  contacts            :text
#  how_to_participate  :text
#  registration_fees   :text
#  participants        :text
#  related_events      :text
#  infos_extra         :text
#  rating_count        :integer
#  rating_total        :decimal(, )
#  rating_avg          :decimal(10, 2)
#  publish_state       :string(255)
#

class Event < ActiveRecord::Base
  PUBLIC_URL = "http://fol-events.herokuapp.com/"

  include ActionView::Helpers::SanitizeHelper
  include Publishable
  include Addressable

  acts_as_rated
  acts_as_taggable
  acts_as_taggable_on :typology, :theme

  validates_presence_of :name, :description, :message => "^Vous devez ajouter un nom et une description..."
  validates_presence_of :begin_date, :end_date, :message => "^Vous devez ajouter les dates..."

  default_scope {order("begin_date asc")}
  scope :begin_in, lambda { |value| where('events.begin_date >= ?', ( -1 * value ).days.ago).order("begin_date desc") }
  scope :upcoming, lambda { where("begin_date between ? and ?", Date.today, Date.today.next_month.beginning_of_month)}
  scope :future, lambda { where('events.begin_date >= ?', Time.zone.now) }
  scope :past, lambda { where('events.begin_date <= ?', Time.zone.now) }

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
