require 'state_machine'
module Legco
  module Hansard
    module Filters
      class SpeechFilter
        attr_reader :speeches

        SPEECH_REGEX = %r{^[0-9]*\.?((.*)(主席|議員|局長|司長))：(.+)}

        state_machine :state, :initial => :header do
          event :speak do
            transition all => :speaking
          end

          event :supplement do
            transition all => :supplementing
          end

          state :header do
            def process_line(line)
            end
          end

          state :speaking do
            def process_line(line)
              match = line.match SPEECH_REGEX
              if match
                flush
                full = match[1].strip
                name = match[2].strip
                title = match[3].strip 

                # they dont list full name of 局長/司長
                if title =~ %r{(局長|司長)$}
                  name = nil 
                  title = full
                end
                name = nil if name == ""

                @current_speaker = {:full => full, :name => name, :title => title }
                @current_text = []
                @current_text << match[4].strip
              else
                @current_text << line.strip
              end
            end
          end

          state :supplementing do
            def process_line(line)
              @current_supplement << line.strip
            end
          end
        end

        def initialize
          @current_speaker = nil
          @current_text = []
          @speeches = []
          @current_supplement = []
          super()
        end

        def process(doc)
          doc.text.each_line do |line|
            peek_line(line)
            process_line(line)
          end
          flush

          doc.data[:speeches] = speeches
        end

        # check a line and change state if needed
        def peek_line(line)
          if line.match %r{^(提交文件|附件)}
            supplement
          elsif line.match %r{^主席：}
            speak
          elsif line.match %r{^(議員議案|香港特別行政區行政長官發表施政報告)}
          end
        end

        def flush
          if @current_text.size > 0 && @current_speaker
            @speeches << {
              :speaker => @current_speaker, 
              :text => @current_text.join("\n"),
              :supplement => @current_supplement.size > 0 ? @current_supplement.join("\n") : nil
            }
            @current_supplement = []
            @current_text = []
            @current_speaker = nil
          end
        end
      end
    end
  end
end