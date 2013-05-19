require_relative './filters'

module Legco
  module Hansard
    class Parser
      attr_accessor :filters

      def initialize
        @filters = []
        @filters << Filters::CleanupFilter.new
        @filters << Filters::AttendeeFilter.new
        @filters << Filters::DatetimeFilter.new
        @filters << Filters::SpeechFilter.new

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