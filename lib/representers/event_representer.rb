module EventRepresenter
  include Roar::Representer::JSON
  include Representable::JSON

  property  :id
  property  :name
  property  :begin_date
  property  :description

  property  :subscibe_limit_date
  property  :end_date
  property  :attendance
  property  :contacts
  property  :how_to_participate
  property  :registration_fees
  property  :participants
  property  :related_events
  property  :infos_extra
  property  :rating_count
  property  :rating_total
  property  :rating_avg
  property  :publish_state

  property :position
  property :event_address

  def position
    {lat: represented.address.latitude , lon: represented.address.longitude}
  end

  def event_address
    represented.address.address
  end

end