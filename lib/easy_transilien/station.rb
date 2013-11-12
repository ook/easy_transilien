module EasyTransilien
  class Station
    attr_accessor :name, :external_code, :access_time

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

      # Find a list of [Station] matching +criterium+.
      # Valid keys:
      # * String: will try to match +name+ or +external_code+. Both case unsensitive.
      def find(criterium)
        stations = []
        if criterium.is_a?(String)
          regex = /#{criterium}/i
          matching = all_stop_areas.reject { |sa| sa.name !~ regex && sa.external_code !~ regex }
          stations = matching.map do |sa|  
            item = new
            item.name = sa.name
            item.external_code = sa.external_code
            item.access_time = sa.access_time
            item
          end
        elsif criterium.is_a?(Station)
          stations << criterium
        end
        stations
      end
    end
  end
end
