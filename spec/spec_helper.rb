$LOAD_PATH << "lib"
require 'legco'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

def test_doc
  data = open(File.join(File.dirname(__FILE__), "fixtures/cm1121-translate-c-small.txt")).read
  doc = Legco::Handsard::Document.new(data)
  cleanup = Legco::Handsard::Filters::CleanupFilter.new
  cleanup.process doc
  doc
end