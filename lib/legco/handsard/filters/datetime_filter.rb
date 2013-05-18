require 'time'

module Legco
  module Handsard
    module Filters
      # Extract Date and Time of the meeting
      class DatetimeFilter
        def process(doc)
          date_matches = doc.text.match %r{\n會議過程正式紀錄\s*\n([0-9]{4})年([0-9]{2})月([0-9]{2})日星期.\s*\n}
          if date_matches
            doc.date = Date.new(date_matches[1].to_i, date_matches[2].to_i, date_matches[3].to_i)
          end
        end
      end
    end
  end
end