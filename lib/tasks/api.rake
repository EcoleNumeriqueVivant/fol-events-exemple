require 'sanitize'

namespace :api do
  desc "Print out API routes"
  task :routes => :environment do
    FOL::API::Root.routes.each do |route|
      info = route.instance_variable_get :@options
      description = "%-40s..." % info[:description][0..39]
      method = "%-7s" % info[:method]
      puts "#{description}  #{method}#{info[:path]}"
    end
  end
end

namespace :db do
  task :sanetize => :environment do

    Event.all.each do |e|
      e.description           = Sanitize.fragment(e.description)
      e.contacts              = Sanitize.fragment(e.contacts)
      e.how_to_participate    = Sanitize.fragment(e.how_to_participate)
      e.registration_fees     = Sanitize.fragment(e.registration_fees)
      e.participants          = Sanitize.fragment(e.participants)
      e.related_events        = Sanitize.fragment(e.related_events)
      e.infos_extra           = Sanitize.fragment(e.infos_extra)
      e.save
    end

  end
end