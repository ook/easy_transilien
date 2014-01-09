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
    include Comparable
    attr_accessor :from_station, :to_station, :from_stop, :to_stop, :access_time
    attr_accessor :start_time, :arrival_time
    attr_accessor :mission
    attr_accessor :ms_journey

    attr_accessor :at
    attr_accessor :stops

    class << self
      
      # Find 
      # Options:
      # * at (default Time.new)
      # * last (default at + 3600)
      # * whole_day: if true, override at and last with respectively 00:01 and 00:00
      # * return: if true, invert from and to
      def find(from, to , options= {})
        at = last = nil
        if options[:whole_day]
          now = Time.new
          at = Time.new(now.year, now.month, now.day, 0, 0, 1)
          last = at + 86400
        end
        if options[:return]
          from_was = from
          from = to
          to = from_was
        end
        at ||= Time.new
        raise "at params MUST be a valid Time instance. Given: #{at.inspect}" unless at.is_a?(Time)
        last ||= at + 3600
        raise "last params MUST be a valid Time instance. Given: #{last.inspect}" unless last.is_a?(Time)

        from_station = Station.find(from).first
        to_station   = Station.find(to).first

        raise "Can't find a Station from #{from.inspect}" unless from_station
        raise "Can't find a Station from #{to.inspect}"   unless to_station

        routes   = Transilien::Route.find(stop_area_external_code: {and: [from_station.external_code, to_station.external_code] }, check_order: 1)
        journeys = Transilien::VehicleJourney.find(route_external_code: routes.map(&:external_code), date: Transilien.date(at), start_time: Transilien.time(at), end_time: Transilien.time(last))

        trips = []

        journeys.each do |journey|
          item = new
          item.at            = at
          item.from_station  = from_station
          item.to_station    = to_station
          item.stops         = journey.stops.map do |ms_stop|
            s = EasyTransilien::Stop.new
            s.ms_stop = ms_stop
            s
          end.sort
          item.from_stop     = item.stops.select { |ts| ts.station_external_code == from_station.external_code }.first
          item.to_stop       = item.stops.select { |ts| ts.station_external_code == to_station.external_code   }.first
          next if item.from_stop.nil? || item.to_stop.nil? # drop item if this journey doesn't deserve our from_stop or to_stop
          item.access_time   = journey.access_time
          item.ms_journey       = journey
          item.mission       = journey.name
          item.start_time    = item.from_stop.ms_stop.stop_time.time
          item.arrival_time  = item.to_stop.ms_stop.stop_time.time

          trips << item

        end
        trips.sort
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

    def to_s
      "[#{mission}] #{from_stop} -> #{to_stop}"
    end

    def inspect
      "<EasyTransilien::Trip:#{object_id} @access_time=#{access_time} @mission=#{mission} @from_stop=#{from_stop}, @to_stop=#{to_stop}>"
    end

    def <=>(another)
      self.from_stop.time <=> another.from_stop.time
    end

  end
end
