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

  property  :infos
  property  :rating

  property  :position
  property  :location

  property :types
  property :themes

  def infos
    {
      attendance: represented.attendance,
      contacts: represented.contacts,
      how_to_participate: represented.how_to_participate,
      registration_fees: represented.registration_fees,
      participants: represented.participants,
      related_events: represented.related_events,
      infos_extra: represented.infos_extra
    }
  end

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

  def location
    represented.address.address
  end

  def types
    represented.typology_list
  end

  def themes
    represented.theme_list
  end

end