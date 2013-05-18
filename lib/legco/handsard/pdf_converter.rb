require 'pdf-reader'

module Legco
  module Handsard
    class PdfConverter
      def convert(pdf_filename, txt_filename)
        File.open(txt_filename, 'w:UTF-8') do |file|
          PDF::Reader.open(pdf_filename, 'rb') do |reader|
            reader.pages.each do |page|
              file.write page.text
            end
          end
        end
      end
    end
  end
end