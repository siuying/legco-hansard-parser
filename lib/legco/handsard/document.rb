module Legco
  module Handsard
    class Document
      attr_accessor :text
      attr_accessor :date      
      attr_accessor :data

      def initialize(text)
        @text = text
        @data = {}
      end
    end
  end
end