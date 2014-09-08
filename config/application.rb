require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FolEvents
  class Application < Rails::Application

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib', 'representers')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

    config.generators do |g|
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
    end
    config.sass.preferred_syntax    = :sass
    config.sass.line_comments       = false
    config.sass.cache               = false

    config.generators.stylesheets   = false
    config.generators.javascripts   = false
    config.generators.helper        = false

    config.middleware.use Rack::Cors do
        allow do
          origins '*'
          # location of your API
          resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
          resource '/users/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
        end
    end
  end
end
