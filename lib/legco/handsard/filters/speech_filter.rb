module Legco
  module Handsard
    module Filters
      class SpeechFilter
        def process(doc)
          speeches = doc.text.scan(%r{((.+)(主席|局長|議員))：([\W.\n0-9]+)})
            .collect{|m| {:speaker => m[0], :text => m[4]} }
          doc.data[:speeches] = speeches
        end
      end
    end
  end
end