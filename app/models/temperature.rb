require 'riak'
require 'active_support'
require 'date'

module Models

  class Temperature

    def self.create_table!
      sql = 'CREATE TABLE Temperature
            (
               device       VARCHAR   NOT NULL,
               core         VARCHAR   NOT NULL,
               time         TIMESTAMP NOT NULL,
               temperature  DOUBLE,
               PRIMARY KEY (
                 (device, core, QUANTUM(time, 5, "m")),
                 device, core, time
               )
            )
            '
      query = Riak::TimeSeries::Query.new(client, sql)
      query.issue!
    end

    def self.client
      @@client ||= Riak::Client.new(nodes: [
        { host: '192.168.99.100', pb_port: 32770 }
      ])
    end

    def self.recent(core, device)
      query = Riak::TimeSeries::Query.new(client, "select temperature, time from Temperature where time > #{(Time.now - 5.minutes).to_i} and time < #{Time.now.to_i} and device = '#{device}' and core = '#{core}'")

      response = query.issue!

      response.map do |(temperature, time)|
        { temperature: temperature, time: Time.at(time).to_datetime }
      end
    end

    def self.recent_average(core, device)
      query = Riak::TimeSeries::Query.new(client, "select AVG(temperature) from Temperature where time > #{(Time.now - 1.hour).to_i} and time < #{Time.now.to_i} and device = '#{device}' and core = '#{core}'")

      response = query.issue!

      { average_temperature: response.flatten.first }
    end


    def initialize(device, core, temperature)
      @device = device
      @core = core
      @temperature = temperature
    end

    def save
      submission = Riak::TimeSeries::Submission.new(self.class.client, "Temperature")
      submission.measurements = [[ @device, @core, Time.now.to_i, @temperature ]]
      submission.write!
    end
  end

end
