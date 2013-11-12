module EasyTransilien
  # EasyTransilien::Trip
  # This class give you the differents Train from one point to an other point, on the same Transilien::Route, in the Time boudaries you
  # gave.
  #
  # The key method id Trip.find(from, to, at, last)
  # You can let [at] and [last] params empty: in that case [at] will be right now, and [last] will be in 1 hour later than [at]
  #
  # A trip is the EasyTransilien representation from Transilien::VehicleJourney
  class Trip
    attr_accessor :from_station, :to_station, :access_time
    attr_accessor :start_time, :arrival_time
    attr_accessor :journey

    class << self
      
      # Find 
      def find(from, to , at = Time.new, last = nil )
        raise "at params MUST be a valid Time instance. Given: #{at.inspect}" unless at.is_a?(Time)
        last ||= at + 3600
        raise "last params MUST be a valid Time instance. Given: #{last.inspect}" unless last.is_a?(Time)

        from_station = Station.find(from).first
        to_station = Station.find(to).first

        raise "Can't find a Station from #{from.inspect}" unless from_station
        raise "Can't find a Station from #{to.inspect}"   unless to_station

        routes   = Transilien::Route.find(stop_area_external_code: {and: [from_station.external_code, to_station.external_code] }, check_order: 1)
        journeys = Transilien::VehicleJourney.find(route_external_code: routes.map(&:external_code), date: Transilien.date(at), start_time: Transilien.time(at), end_time: Transilien.time(last))

        trips = []

        journeys.each do |journey|
          item = new
          item.from_station  = from_station
          item.to_station    = to_station
          item.access_time   = journey.access_time
          item.journey       = journey

          trips << item
        end
        trips
      end

    end

    def external_code
      journey.external_code
    end

    def from_station_name
      from_station.name
    end

    def to_station_name
      to_station.name
    end

  end
end
