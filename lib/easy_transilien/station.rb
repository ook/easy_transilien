module EasyTransilien
  class Station
    attr_accessor :name, :external_code, :access_time
    attr_accessor :ms_stop_area

    class << self
      # Get all available `Transilien::StopArea`
      # == See:
      # `transilien_microservices` gem
      def all_stop_areas(options = {})
        options[:force] ||= false
        if options[:force] || @all_stop_areas.nil?
          @all_stop_areas = ::Transilien::StopArea.find
        end
        @all_stop_areas
      end

      # Find a list of `Station` matching +criterium+.
      # Valid keys:
      # @param [String] criterium will try to match +name+ or +external_code+. Both case unsensitive.
      def find(criterium = nil)
        if criterium.is_a?(String)
          regex = /#{criterium}/i
          matching = all_stop_areas.reject { |sa| sa.name !~ regex && sa.external_code !~ regex }
          return convert_stop_areas_to_stations(matching)
        elsif criterium.is_a?(Station)
          return [criterium]
        elsif criterium.is_a?(Hash)
          matching = []
          if criterium.keys.include?(:line_external_code)
            all_stop_areas.select { |sa| raise sa.inspect }
          end
          return convert_stop_areas_to_stations(matching)
        elsif criterium.nil?
          return convert_stop_areas_to_stations(all_stop_areas)
        else
          raise 'WAZZUF?'
        end
      end

      def convert_stop_areas_to_stations(stop_areas)
        stop_areas.map do |sa|  
          item = new
          item.name          = sa.name
          item.external_code = sa.external_code
          item.access_time   = sa.access_time
          item.ms_stop_area  = sa
          item
        end
      end

    end

    def lines
      @lines ||= EasyTransilien::Line.find()
    end

    def codes
       @codes ||= ms_stop_area.lines.map(&:code).flatten.uniq.sort#.reject { |c| c.length != 1 } # DEV NOTE lines with more than 1 letter are special lines for "travaux"
    end

    def coord(format = :gps)
      if format == :gps
      end
    end
  end

end
