require "app/models"
require "app/routes"

class App < Sinatra::Base

  register Sinatra::Initializers

  configure do
    set :root, APP_ROOT.to_s
  end

  # register default middlewares
  # use Rollbar::Middleware::Sinatra

  # register API endpoints as middlewares
  use Routes::V1::Stats

  not_found do
    halt(404, {}, { error: "Not found", code: 404 }.to_json)
  end

end
