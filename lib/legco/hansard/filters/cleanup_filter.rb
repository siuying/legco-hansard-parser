module Legco
  module Hansard
    module Filters
      class CleanupFilter
        HEADER_REGEX = %r{(\A|\n)立法會\s*─\s*[0-9]{4}年\s*[0-9]{1,2}月\s*[0-9]{1,2}日\s*\n\s*[A0-9]+}

        def process(document)
          document.text.gsub! HEADER_REGEX, ''
        end
      end
    end
  end
end