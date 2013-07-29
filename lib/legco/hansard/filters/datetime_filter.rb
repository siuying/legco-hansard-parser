require 'time'
require 'pry'

module Legco
  module Hansard
    module Filters
      # Extract Date and Time of the meeting
      class DatetimeFilter
        def process(doc)
          date_matches = doc.text.match %r{會議過程正式紀錄\s*\n\s*\n([0-9]{4})年 ?([0-9]{1,2})月 ?([0-9]{1,2})日星期.}
          if date_matches
            year = date_matches[1].to_i
            month = date_matches[2].to_i
            date = date_matches[3].to_i
          else
            raise "date not found"
          end

          time_matches = doc.text.match %r{(.午) ?([0-9]{1,2})時(正|(.*分))會議(開始|繼續)}
          if time_matches
            apm = time_matches[1]
            hour = time_matches[2]
            minute = time_matches[3]

            hour = hour.to_i

            if minute == "正"
              minute = 0
            else
              minute = minute.to_i
            end

            if apm == "下午"
              hour += 12
            end
          else
            raise "time not found"
          end

          doc.date = DateTime.new(year, month, date, hour, minute, 0)
        end
      end
    end
  end
end