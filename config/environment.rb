# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FolEvents::Application.initialize!

require 'icalendar'

# EXPAND_PATH = File.expand_path(File.dirname(__FILE__))
# require EXPAND_PATH + "/../lib/MailChimp.rb"

# require 'bossman'
# BOSSMan.application_id = ["e_fbPrTV34H4V8jeypuDhiCkMEs2MvyEnClFlgQByBYKfJcrMT6u8nNS7bXRk66S5hWAno4rYXnBYA--"]
# ["mh_hGnPV34FYaDcIKoG4Q2l029SJqmFxOCGdbuL6oTYM41mOhUbxqG5TBSiJzeJ7vLsxZGZKFDDPUA--"]