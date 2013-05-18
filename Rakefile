require 'rake'
$LOAD_PATH << "lib"
require 'legco'

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