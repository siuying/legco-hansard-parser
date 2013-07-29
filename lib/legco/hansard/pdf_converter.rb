module Legco
  module Hansard
    class PdfConverter
      JAR_VERSION = "1.8.2"
      JAR_PATH = File.join(File.dirname(__FILE__), "../../../jar/pdfbox-app-#{JAR_VERSION}.jar")

      def convert(pdf_filename, txt_filename)
        system("java -jar #{JAR_PATH} ExtractText -encoding \"UTF-8\" \"#{pdf_filename}\" #{txt_filename}")
      end
    end
  end
end