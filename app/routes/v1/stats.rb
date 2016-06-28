require "app/models/temperature"

module Routes

  module V1

    class Stats < ApiBase

      namespace '/v1' do

        get '/:core/:device/stats' do
          measurements = Models::Temperature.recent_average(params[:core], params[:device])

          [200, {}, measurements.to_json]
        end

      end

    end

  end

end
