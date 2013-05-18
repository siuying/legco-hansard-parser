require_relative './filters/cleanup_filter'

module Legco
  module Handsard
    class Parser
      attr_accessor :filters

      def initialize
        @filters = []
        @filters << CleanupFilter.new
      end

      def parse(document)
        @filters.each do |filter|
          filter.process(document)
        end
        document
      end
    end
  end
end