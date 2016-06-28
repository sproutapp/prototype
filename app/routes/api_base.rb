require "sinatra/namespace"

module Routes

  class ApiBase < Sinatra::Base

    register Sinatra::Namespace

    # set JSON as default content type
    before do
      content_type :json
    end

    # register JSON parser
    use Rack::Parser, parsers: {
      "application/json" => -> (body) { JSON.parse(body) }
    }

  end

end
