require 'rake'
$LOAD_PATH << "lib"
require 'legco'
require 'open-uri'

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
        filename = File.basename(url)
        output_file = "#{output_path}/#{filename}"

        unless File.exists?(output_file)
          system "wget \"#{url}\" -O \"#{output_file}\""
        end
      end
    end
  end
end

task :convert do
  data = open(File.join(File.dirname(__FILE__), "./spec/fixtures/cm1121-translate-c-small.txt")).read
  doc = Legco::Handsard::Document.new(data)
  parser = Legco::Handsard::Parser.new
  parser.parse(doc)

  File.open("data/cm1121-translate-c.json", 'w') do |f|
    f.write doc.to_json
  end
end

task :default => :convert