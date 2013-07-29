# encoding: utf-8
require 'state_machine'
module Legco
  module Hansard
    module Filters
      # extract events from hansard
      # events include speech and action
      class EventFilter
        attr_reader :events

        SPEECH_REGEX = %r{^[0-9]*\.?((.*)(代理主席|行政長官|主席|議員|局長|司長))：(.+)}
        NOT_SPEECH_REGEX = %r{^(出席議員|缺席議員|出席政府官員|列席秘書)}

        ACT_BEGIN_REGEX = %r{^\(([^\)]+)\)?\s*$}
        ACT_END_REGEX = %r{([^\)]+)\)\s*$}

        state_machine :state, :initial => :header do
          event :speak do
            transition all => :speaking
          end
          
          event :act do
            transition :speaking => :acting
          end

          event :supplement do
            transition all => :supplementing
          end

          after_transition :on => :speak, :do => :flush

          state :header do
            def process_line(line)
            end
          end

          state :acting do
            def process_line(line)
              match = line.match(ACT_BEGIN_REGEX)
              if match
                @actions << match[1]

                if line.match(ACT_END_REGEX)
                  speak
                end

                return
              end

              match = line.match(ACT_END_REGEX)
              if match
                @actions << match[1]
                speak
                return
              end

              @actions << line
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
          @events = []
          @current_text = []
          @current_supplement = []
          @actions = []
          super()
        end

        def process(doc)
          doc.text.each_line do |line|
            peek_line(line)
            process_line(line)
          end
          flush

          doc.data[:events] = events
        end

        # check a line and change state if needed
        def peek_line(line)
          if line.match %r{^(提交文件|附件|註)}
            supplement
          elsif line.match(SPEECH_REGEX) && !line.match(NOT_SPEECH_REGEX)
            speak
          elsif line.match %r{^\([^\)]+\)?\s*$}
            if speaking?
              act
            end
          elsif line.match %r{\)\s*$}
            # end of act
          elsif line.match %r{^(議員議案|香港特別行政區行政長官發表施政報告)}
            # context
          end
        end

        def flush
          if @current_text.size > 0 && @current_speaker
            text = @current_text.join("\n").strip
            supplement = @current_supplement.size > 0 ? @current_supplement.join("\n").strip : nil
            if text != "" || supplement != ""
              @events << {
                :type => :speech,
                :speaker => @current_speaker, 
                :text => text,
                :supplement => supplement
              }
            end
            @current_supplement = []
            @current_text = []
          end

          if @actions.size > 0
            text = @actions.join("\n").strip
            if text != ""
              @events << {
                :type => :action,
                :text => @actions.join("\n").strip
              }
            end

            @actions = []
          end
        end
      end
    end
  end
end