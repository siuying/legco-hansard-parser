module Legco
  module Hansard
    module Filters
      class SpeechFilter

        attr_reader :speeches

        SPEECH_REGEX = %r{^[0-9]*\.?(.+(主席|局長|議員|司長))：(.+)}

        def initialize
          @current_speaker = nil
          @current_text = []
          @speeches = []
        end

        def process(doc)
          doc.text.each_line do |line|
            process_line(line)
          end
          flush

          doc.data[:speeches] = speeches
        end

        protected
        def process_line(line)
          match = line.match SPEECH_REGEX
          if match
            flush
            @current_speaker = match[1].strip
            @current_text = []
            @current_text << match[3].strip
          else
            @current_text << line.strip
          end
        end

        def flush
          if @current_text.size > 0 && @current_speaker
            @speeches << {
              :speaker => @current_speaker, 
              :text => @current_text.join("\n")
            }
          end
        end
      end
    end
  end
end