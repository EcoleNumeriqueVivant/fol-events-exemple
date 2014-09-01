require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FolEvents
  class Application < Rails::Application
    # Add Bower components
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    config.middleware.use Rack::Cors do
        allow do
          origins '*'
          # location of your API
          resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put]
        end
    end
  end
end
