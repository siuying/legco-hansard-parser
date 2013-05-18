module Legco
  module Handsard
    module Filter
      class CleanupFilter
        def initialize
        end

        def process(document)
          document.text.gsub! %r{立法會 ─ [0-9]{4}年[0-9]{1,2}月[0-9]{1,2}日\s\n\s+[0-9]+\s+}, ''
        end
      end
    end
  end
end