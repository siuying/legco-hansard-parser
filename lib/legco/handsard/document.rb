module Legco
  module Handsard
    class Document
      attr_accessor :text

      def initialize(text)
        @text = text
      end
    end
  end
end