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
      Pusher.app_id = ''
      Pusher.key = ''
      Pusher.secret = ''
    end
  end
end
