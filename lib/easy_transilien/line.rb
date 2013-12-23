module EasyTransilien
  # ET::Line is NOT the translation of MS::Line
  # It's the port of commercial names known by customers: "Ligne J", "Ligne L", etc.
  # So, it's a collection of MS::Line, with (normally) a common MS::Network
  class Line
    attr_accessor :name, :access_time, :codes
    attr_accessor :ms_network

    class << self
      def all_networks(options = {})
        options[:force] ||= false
        if options[:force] || @all_networks.nil?
          @all_networks = ::Transilien::Network.find
        end
        @all_networks
      end

      def all_ms_lines(options = {})
        options[:force] ||= false
        if options[:force] || @all_ms_lines.nil?
          @all_ms_lines = ::Transilien::Line.find
        end
        @all_ms_lines
      end

      # Find a line via a single letter (A,B,C,D,E,I,J,K,L, etc.)
      def find(criterium = nil)
        if criterium.is_a?(String)
          regexp = /#{criterium}/i
          matching = all_networks.reject { |n| n.name !~ regexp && n.external_code !~ regexp && !n.codes.map(&:downcase).include?(criterium.downcase) }
          if matching.length == 1 # Ok, seems sucessful
            return convert_networks_to_lines(matching)
          end
        elsif criterium.nil?
          # No Args? Return everything.
          return convert_networks_to_lines(all_networks)
        else
          raise "Can't understand #find criteria: not a letter, not nil, not a network line name: #{criterium.inspect}"
        end
      end

      def convert_networks_to_lines(networks)
        networks.map do |n|
          item = new
          item.name          = n.name
          item.access_time   = n.access_time
          item.ms_network    = n
          item.ms_lines << n.lines
          item.ms_lines.compact!
          item
        end
      end
    end # << self

    def line_external_codes
      @lines_external_codes ||= begin
        return nil unless ms_lines
        ms_lines.map(&:external_code).sort.uniq
      end
    end

    def codes
      @codes ||= ms_lines.map(&:code).flatten.uniq.sort.reject { |code| code.length != 1 } # DEV NOTE lines with more than 1 letter are special lines for "travaux"
    end

    def ms_lines
      @ms_lines ||= []
      @ms_lines.flatten!
      @ms_lines
    end

    def stations
      @stations ||= EasyTransilien::Station.convert_stop_areas_to_stations(ms_lines.map { |ms_line| ms_line.stop_areas }.flatten.uniq)
    end

  end
end
