require 'rake'
$LOAD_PATH << "lib"
require 'legco'
require 'open-uri'
require 'fileutils'

namespace :download do
  task :list do
    lister = Legco::Handsard::Lister.new
    data = lister.list

    File.open("data/hansard_list.json", 'w') do |f|
      f.write JSON.pretty_generate data
    end
  end

  # download hansard as pdf
  task :handsard do 
    output_path = "data/pdf"

    data = JSON(open("data/hansard_list.json").read)
    data.each do |meeting|
      meeting["hansard"].each do |url|
        match = url.match(%r{/yr([0-9\-]+?)/})
        year = match ? match[1] : ""

        filename = File.basename(url)
        output_file = "#{output_path}/#{year}-#{filename}"

        puts "Download PDF: #{url}"
        unless File.exists?(output_file)
          system "wget \"#{url}\" -O \"#{output_file}\""
        end
      end
    end
  end
end

namespace :convert do
  task :txt do
    output_path = "data/txt"
    converter = Legco::Hansard::PdfConverter.new

    Dir.glob("data/pdf/*.pdf").each do |pdf|
      filename = File.basename(pdf).split(".").first + ".txt"
      output_filename = "#{output_path}/#{filename}"

      puts "Converting PDF: #{pdf}"
      converter.convert(pdf, output_filename)
    end
  end

  task :json do
    output_path = "data/json"
    parser = Legco::Hansard::Parser.new

    FileUtils.mkdir_p(output_path)

    Dir.glob("data/txt/*.txt").each do |text|
      filename = File.basename(text).split(".").first + ".json"
      output_filename = "#{output_path}/#{filename}"

      puts "Converting JSON: #{text}"
      doc = Legco::Hansard::Document.new(open(text).read)
      parser.parse(doc)

      File.open(output_filename, 'w') do |f|
        f.write doc.to_json
      end
    end
  end
end