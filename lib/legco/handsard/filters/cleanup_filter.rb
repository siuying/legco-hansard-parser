module Legco
  module Handsard
    module Filters
      class CleanupFilter
        HEADER_REGEX = %r{立法會 ─ [0-9]{4}年[0-9]{1,2}月[0-9]{1,2}日\s\n\s*[0-9]+\s*}

        def process(document)
          document.text.gsub! HEADER_REGEX, ''
        end
      end
    end
  end
end