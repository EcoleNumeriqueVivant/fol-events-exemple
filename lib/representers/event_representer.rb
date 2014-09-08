module EventRepresenter
  include Roar::Representer::JSON
  include Representable::JSON

  property  :id
  property  :name
  property  :description

  property  :begin_date
  property  :end_date
  property  :subscibe_limit_date
  property  :publish_state

  property  :attendance
  property  :contacts
  property  :how_to_participate
  property  :registration_fees
  property  :participants
  property  :related_events
  property  :infos_extra

  property  :rating

  property :position
  property :event_address

  property :types
  property :themes

  def rating
    {
      count: represented.rating_count,
      total: represented.rating_total,
      avg: represented.rating_avg
    }
  end

  def position
    {lat: represented.address.latitude , lon: represented.address.longitude}
  end

  def event_address
    represented.address.address
  end

  def types
    represented.typology_list
  end

  def themes
    represented.theme_list
  end

end