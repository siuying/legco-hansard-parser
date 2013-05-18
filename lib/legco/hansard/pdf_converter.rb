module Legco
  module Hansard
    class PdfConverter
      JAR_PATH = File.join(File.dirname(__FILE__), "../../../jar/pdfbox-app-1.8.1.jar")

      def convert(pdf_filename, txt_filename)
        system("java -jar #{JAR_PATH} ExtractText -encoding \"UTF-8\" \"#{pdf_filename}\" #{txt_filename}")
      end
    end
  end
end