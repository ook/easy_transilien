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

      def find(criterium)
        regex = /#{criterium}/i
        matching = all_stop_areas.reject { |sa| sa.name !~ regex }
        matching.map do |sa|  
          item = new
          item.name = sa.name
          item.external_code = sa.external_code
          item.access_time = sa.access_time
          item
        end
      end
    end
  end
end
