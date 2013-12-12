module EasyTransilien
  # ET::Line is NOT the translation of MS::Line
  # It's the port of commercial names known by customers: "Ligne J", "Ligne L", etc.
  # So, it's a collection of MS::Line, with a common MS::Network
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

      # Find a line via a single letter (A,B,C,D,E,I,J,K,L
      def find(criterium = nil)
        if criterium.is_a?(String)
          regexp = /#{criterium}/i
          matching = all_networks.reject { |n| n.name !~ regexp && n.external_code !~ regexp }
          return convert_networks_to_lines(matching)
        else
          return convert_networks_to_lines(all_networks)
        end
      end

      def convert_networks_to_lines(networks)
        networks.map do |n|
          item = new
          item.name          = n.name
          item.line_external_codes << n.external_code
          item.access_time   = n.access_time
          item.ms_network    = n
          item.ms_lines << n.lines
          item
        end
      end
    end # << self

    def line_external_codes
      @lines_external_codes ||= []
      @lines_external_codes.flatten!
      @lines_external_codes
    end

    def codes
      @codes ||= ms_lines.map(&:code).flatten.uniq.sort.reject { |code| code.length > 1 } # DEV NOTE lines with more than 1 letter are special lines for "travaux"
    end

    def ms_lines
      @ms_lines ||= []
      @ms_lines.flatten!
      @ms_lines
    end

    def stations
      Transilien::Stop
    end

  end
end
