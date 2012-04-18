# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FolEvents::Application.initialize!

require 'icalendar'

# EXPAND_PATH = File.expand_path(File.dirname(__FILE__))
# require EXPAND_PATH + "/../lib/MailChimp.rb"
