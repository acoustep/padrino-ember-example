require 'pusher'

module Api
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :patch]
      end
    end

    configure do
      Pusher.app_id = '87906'
      Pusher.key = '4fdbf9e3a2d3c8de99ea'
      Pusher.secret = '1275165be692f65dd650'
    end
  end
end
