module EasyTransilien
  class Stop
    include Comparable
    attr_accessor :ms_stop

    def access_time
      ms_stop && ms_stop.access_time
    end

    def stop_time
      @stop_time ||= ms_stop && ms_stop.stop_time
    end

    def station_name
      @station_name ||= ms_stop && ms_stop.stop_point.name
    end

    def name_at_stop
      ms_stop && ms_stop.name_at_stop
    end

    def stop_point_idx
      @stop_point_idx ||= ms_stop && ms_stop.stop_point.payload['StopPointIdx']
    end


    def station_external_code
      @station_external_code ||= ms_stop && ms_stop.stop_point.external_code
    end

    def time
      now = Time.new
      year  =  access_time && access_time.year  || now.year
      month =  access_time && access_time.month || now.month
      day   = (access_time && access_time.day   || now.day) + stop_time.day.to_i
      Time.local(year, month, day, stop_time.hour, stop_time.minute)
    end

    def to_s
      "#{station_name}#{"(#{name_at_stop})" if name_at_stop}@#{stop_time.day.to_i > 0 ? "(+#{stop_time.day.to_i})" : '' }#{'%02d' % stop_time.hour}:#{'%02d' % stop_time.minute}"
    end

    # Comparable Stuff
    def <=>(another)
      self.time <=> another.time
    end
  end

end
