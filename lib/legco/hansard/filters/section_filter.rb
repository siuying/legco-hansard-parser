module Legco
  module Hansard
    module Filters
      class SectionFilter
        def process(doc)
          sections = []
          current_section = 1
          while section = find_section(current_section, doc)
            sections << section
            current_section += 1
          end
          doc.data[:sections] = sections.compact
        end

        private
        def find_section(section, doc)
          next_section = section
          matches = doc.text.match %r{^([^0-9\.：]+?)\n\s*^#{section}\.? (.+)^#{next_section}\.?}m
          if matches
            {:title => matches[1], :id => section, :text => matches[2]}
          else
            nil
          end
        end
      end
    end
  end
end