# coding: utf-8

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


title = "#{@event.name}"

# Assign the path to logo
logopath = "#{Rails.root}/public/images/fontaineolivres.jpg"

xml.instruct!
xml.pdf do
  xml.page :orientation => "portrait" do

    xml.div :x => 190, :y => 790 do
     xml.image  :path => logopath,
     :width =>  146, :height => 51
    end
    
    xml.div :x => 10, :y => 710 do
      xml.text  title,
      :name => "table_head", 
      :x => 0, :y => 0, 
      :width => 500, :height => 25,
      :options => '{ :align => :center, :size => 16, :font_style => :bold, :text_color => "00000" }'
    end

    xml.div :x => 10, :y => 660 do
      t = ""
      t = t + "Fonctionnement et Description :\n" + (Hpricot.uxs @event.description) unless @event.description.nil? 
      t = t + "\n\nContacts :\n" + (Hpricot.uxs @event.contacts) unless @event.contacts.nil? 
      t = t + "\n\nModalités de participation :\n" + (Hpricot.uxs @event.how_to_participate) unless @event.how_to_participate.nil? 
      t = t + "\n\nTarifs :\n" + (Hpricot.uxs @event.registration_fees) unless @event.registration_fees.nil? 
      t = t + "\n\nType de participants :\n" + (Hpricot.uxs @event.participants) unless @event.participants.nil? 
      t = t + "\n\nEvènements rattachés :\n" + (Hpricot.uxs @event.related_events) unless @event.related_events.nil? 
      t = t + "\n\nInformation Supplémentaires :\n" + (Hpricot.uxs @event.infos_extra) unless @event.infos_extra.nil? 
      xml.text t.gsub(/<\/?[^>]*>/, "")
    end
    
  end
end