source 'http://rubygems.org'

ruby '2.1.2'

def linux?; !! RUBY_PLATFORM =~ /linux/ end
def darwin?; !! RUBY_PLATFORM =~ /darwin/ end
def darwin12?; !! RUBY_PLATFORM =~ /darwin12/ end

gem 'rails',                      '4.1.1'
gem 'puma',                       '~> 2.8.2'
gem 'pg',                         '~> 0.17.1'
gem 'uglifier',                   '>= 1.3.0'

gem 'sass-rails',                 '~> 4.0.3'
gem 'haml-rails'
gem 'coffee-rails',               '~> 4.0.0'
gem 'compass-rails',              '~> 1.1.7'
gem 'compass'

gem 'gaston'

gem 'devise',                     '~> 3.2.0'
gem 'omniauth',                   '~> 1.2.1'
gem 'omniauth-twitter',           github: 'arunagw/omniauth-twitter'
gem 'omniauth-facebook',          github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-linkedin-oauth2'

gem 'acts_as_list'
gem 'acts-as-taggable-on'
# geolocation
gem 'geocoder'
gem 'simple_form' # https://github.com/plataformatec/simple_form
gem "country-select",              "~> 1.0.5"
gem 'will_paginate'
# Wysiwyg editor
gem 'tinymce-rails'
gem "icalendar"
# Mailing solution
gem 'gibbon',                     "0.3.5"
gem 'hominid'
gem 'acts_as_commentable_with_threading'
# Annotate
gem 'annotate',                   :git => 'git://github.com/ctran/annotate_models.git'
# By_*
gem 'by_star',                    :git =>'git://github.com/radar/by_star.git'
# xml parser
gem 'nokogiri'
# use prawn to generate invoices, order_form
gem 'ttfunk',                     :git => 'git://github.com/sandal/ttfunk.git'
gem "prawn_rails"
gem 'pdf-renderer',               :git => 'git://github.com/Chussenot/pdf-renderer.git'
gem "hpricot",                    "~> 0.8.6"
gem 'foreman'

gem 'grape',                      '~> 0.9.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'grape-devise',               :git => 'git://github.com/Chussenot/grape-devise.git'
gem 'roar'
gem 'representable'
gem 'sanitize'

gem 'cancan'
gem 'rolify'
gem 'carrierwave'

group :test do
  # Pretty printed test output
  gem 'turn',                     :require => false
  gem 'faker'
  gem 'fabrication'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-expectations'
  gem 'jasmine-rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'rb-inotify',               '~> 0.8' ,  require: linux?
  gem 'rb-fsevent',               '~> 0.9.1', require: darwin?
  gem 'terminal-notifier-guard',  '~> 1.5.3', require: darwin12?
end
